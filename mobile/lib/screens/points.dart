import 'package:flutter/material.dart';
import '../styles/styles.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'detail.dart';

Widget itemContainer() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    padding: EdgeInsets.only(top: 20, bottom: 16, left: 16, right: 16),
    margin: EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
    height: 120,
    width: 120,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.network(
          "http://192.168.100.146:3333/uploads/lampadas.svg",
          height: 50,
        ),
        Text("Lâmpada")
      ],
    ),
  );
}

class Points extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [
      Marker(
          width: 90,
          height: 80,
          point: LatLng(0.0217766, -51.0645172),
          builder: (ctx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Detail()));
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
                        "https://images.unsplash.com/photo-1556767576-5ec41e3239ea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
                        width: 90,
                        height: 65,
                      ),
                    ),
                    Text(
                      "Mercado",
                      style: markerTitleStyle,
                    )
                  ],
                ),
              ),
            );
          })
    ];
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              itemContainer(),
              itemContainer(),
              itemContainer(),
              itemContainer(),
              itemContainer(),
              itemContainer(),
            ],
          ),
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
                    options: MapOptions(
                      // 0.0217766,-51.0645172
                      center: LatLng(0.0217766, -51.0645172),
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
