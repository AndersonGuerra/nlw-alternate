import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:mobile/models/ItemModel.dart';
import 'package:mobile/models/PointModel.dart';
import '../services/http.dart';
import '../styles/styles.dart';
import 'detail.dart';

class Points extends StatefulWidget {
  final String city;
  final String uf;

  Points({this.city, this.uf});

  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  List<ItemModel> items = [];
  List<ItemModel> selectedItems = [];
  List<PointModel> points = [];
  List<Marker> markers = [];
  MapController _mapController = MapController();
  List initialLocation = [0.0, 0.0];

  updatePoints() async {
    var response = await getPoints(widget.city, widget.uf, selectedItems);
    points = [];
    var pointsList = jsonDecode(response.body);
    markers = [];
    pointsList.forEach((point) {
      PointModel pointFromJson = PointModel.fromJson(point);
      points.add(pointFromJson);
      markers.add(Marker(
          width: 90,
          height: 80,
          point: LatLng(pointFromJson.latitude, pointFromJson.longitude),
          builder: (ctx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => Detail(pointFromJson)));
              },
              child: Container(
                width: 90,
                height: 70,
                decoration: BoxDecoration(
                    color: Color(0xff34CB79),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        pointFromJson.image,
                        width: 90,
                        height: 65,
                      ),
                    ),
                    Text(
                      pointFromJson.name,
                      style: markerTitleStyle,
                    )
                  ],
                ),
              ),
            );
          }));
    });
    // .then((response) {

    //   setState(() {});
    // });
  }

  Future getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  @override
  void initState() {
    super.initState();

    getItems().then((response) {
      items = [];
      var itemsList = jsonDecode(response.body);
      itemsList.forEach((item) {
        items.add(ItemModel.fromJson(item));
      });
      setState(() {});
    });

    getLocation().then((locationData) {
      if (locationData.runtimeType == LocationData) {
        initialLocation[0] = locationData.latitude;
        initialLocation[1] = locationData.longitude;
        _mapController.move(LatLng(initialLocation[0], initialLocation[1]), 15);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff34cb79),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.grey[200],
          height: 120,
          child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () async {
                    int isSelected = selectedItems
                        .indexWhere((itemAux) => itemAux.id == items[index].id);
                    if (isSelected >= 0) {
                      selectedItems.removeAt(isSelected);
                    } else {
                      selectedItems.add(items[index]);
                    }
                    await updatePoints();
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: selectedItems.indexWhere((itemAux) =>
                                      itemAux.id == items[index].id) >=
                                  0
                              ? Color(0xff34CB79)
                              : Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.only(
                        top: 20, bottom: 16, left: 16, right: 16),
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                    height: 120,
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.network(
                          items[index].imageUrl,
                          height: 50,
                        ),
                        FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              items[index].title,
                              style: pointsItemStyle,
                            )),
                      ],
                    ),
                  ),
                );
              }),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 32, right: 32, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bem vindo.",
                style: pointsTitleStyle,
              ),
              Text(
                "Encontre no mapa um ponto de coleta.",
                style: pointsDescriptionStyle,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: LatLng(initialLocation[0], initialLocation[1]),
                      zoom: 15.0,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(markers: markers)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
