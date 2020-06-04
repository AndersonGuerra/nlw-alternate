import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../screens/points.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F5),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage("assets/home-background.png"),
                fit: BoxFit.fitWidth)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 64),
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 260),
                  child: Text(
                    "Seu marketplace de coleta de resíduos.",
                    style: homeTitleStyle,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 260),
                  child: Text(
                    "Ajudamos pessoas a encontrarem pontos de coleta de forma eficiente.",
                    style: homeDescriptionStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(32),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color(0xff34CB79),
          height: 60,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Points(),
                ));
          },
          child: Row(
            children: [
              Container(
                  width: 60,
                  height: 60,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
              Expanded(
                child: Text(""),
              ),
              Expanded(
                child: Text("Entrar", style: homeButtonTextStyle),
              ),
              Expanded(
                child: Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
