import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/models/PointDetailedModel.dart';
import 'package:mobile/models/PointModel.dart';
import 'package:mobile/services/http.dart';
import '../styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

launchApp({String phone, String email}) async {
  String whatsappUrl =
      "whatsapp://send?phone=$phone&text=Tenho interesse na coleta de resíduos.";
  String emailUrl = "mailto:$email?subject=Interesse na coleta de resíduos.";
  if (phone != null) {
    await launch(whatsappUrl);
  } else {
    await launch(emailUrl);
  }
}

class Detail extends StatefulWidget {
  final PointModel point;
  Detail(this.point);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  PointDetailModel pointDetailModel;

  @override
  void initState() {
    super.initState();
    getPoint(widget.point.id).then((response) {
      var r = jsonDecode(response.body);
      pointDetailModel = PointDetailModel.fromJson(r);
      print(r);
      setState(() {});
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
        bottomNavigationBar: pointDetailModel != null
            ? Container(
                height: 70,
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minWidth: MediaQuery.of(context).size.width / 2.5,
                        color: Color(0xff34CB79),
                        onPressed: () async {
                          await launchApp(
                              phone: pointDetailModel.point.whatsapp);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text("WhatsApp",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      MaterialButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minWidth: MediaQuery.of(context).size.width / 2.5,
                        color: Color(0xff34CB79),
                        onPressed: () async {
                          await launchApp(email: pointDetailModel.point.email);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.mail, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "E-mail",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(),
        body: pointDetailModel != null
            ? Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        pointDetailModel.point.image,
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        pointDetailModel.point.name,
                        style: homeTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        pointDetailModel.items
                            .map((e) => e.title)
                            .join(', ')
                            .toString(),
                        style: pointsDescriptionStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Endereço",
                            style: pointsAddressTitleStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "${pointDetailModel.point.city}, ${pointDetailModel.point.uf}",
                              style: pointsAddressContentStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
