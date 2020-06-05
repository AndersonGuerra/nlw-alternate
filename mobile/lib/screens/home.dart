import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:mobile/services/http.dart';
import '../styles/styles.dart';
import '../screens/points.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> ufs;
  String selectedUf;
  List<String> cities = [];
  String selectedCity;

  @override
  void initState() {
    super.initState();
    ufs = [];
    getUfs().then((response) {
      var responseJson = jsonDecode(response.body);
      responseJson.forEach((item) {
        ufs.add(item['sigla']);
      });
    });
  }

  Future<List<String>> loadCities() async {
    List<String> citiesAux = [];
    var response = await getCities(selectedUf);
    var responseJson = jsonDecode(response.body);
    responseJson.forEach((item) {
      citiesAux.add(item['nome']);
    });
    return citiesAux;
  }

  showPickerModal(BuildContext context, bool isSelectingUf) async {
    new Picker(
        adapter:
            PickerDataAdapter<String>(pickerdata: isSelectingUf ? ufs : cities),
        changeToFirst: true,
        hideHeader: true,
        cancelText: "Cancelar",
        confirmText: "Confirmar",
        onConfirm: (Picker picker, List value) async {
          var aux =
              picker.adapter.text.substring(1, picker.adapter.text.length - 1);
          if (isSelectingUf) {
            selectedUf = aux;
            cities = await loadCities();
          } else {
            selectedCity = aux;
          }
          setState(() {});
        }).showDialog(this.context); //_scaffoldKey.currentState);
  }

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
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(32),
        child: Container(
          height: 200,
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    selectedUf != null ? selectedUf : "Selecione a UF",
                    style: homeDescriptionStyle,
                  ),
                ),
                onTap: () {
                  if (ufs.length > 0) {
                    showPickerModal(context, true);
                  }
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    selectedCity != null ? selectedCity : "Selecione a cidade",
                    style: homeDescriptionStyle,
                  ),
                ),
                onTap: () {
                  if (selectedUf != null) {
                    showPickerModal(context, false);
                  }
                },
              ),
              MaterialButton(
                padding: EdgeInsets.only(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff34CB79),
                height: 60,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Points(
                          city: selectedCity,
                          uf: selectedUf,
                        ),
                      ));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Container(
                          width: 60,
                          height: 60,
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
