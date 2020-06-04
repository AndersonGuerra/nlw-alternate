import 'package:flutter/material.dart';
import '../styles/styles.dart';

class Detail extends StatelessWidget {
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
          height: 70,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.grey))),
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
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text("WhatsApp", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: MediaQuery.of(context).size.width / 2.5,
                  color: Color(0xff34CB79),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.mail, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text("E-mail", style: TextStyle(color: Colors.white),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "https://images.unsplash.com/photo-1556767576-5ec41e3239ea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60",
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  "Mercado do DIO",
                  style: homeTitleStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Lâmpadas, Oleo de Cozinha",
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
                        "Macapa, AP",
                        style: pointsAddressContentStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
