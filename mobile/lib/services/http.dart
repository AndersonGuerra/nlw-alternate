import 'package:http/http.dart' as http;

String baseUrl = "http://192.168.100.146:3333";

Future getItems() async {
  var response = await http.get("$baseUrl/items");
  return response;
}

Future getPoints(String city, String uf) async {
  var response = await http.get("$baseUrl/points?city=$city&uf=$uf&items=4");
  return response;
}

Future getPoint(id) async {
  var response = await http.get("$baseUrl/points/$id");
  return response;
}

Future getUfs() async {
  var response = await http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados");
  return response;
}

Future getCities(String uf) async {
  var response = await http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios");
  return response;
}
