class PointModel {
  int id;
  String image;
  String name;
  String email;
  String whatsapp;
  double latitude;
  double longitude;
  String city;
  String uf;

  PointModel(
      {this.id,
      this.image,
      this.name,
      this.email,
      this.whatsapp,
      this.latitude,
      this.longitude,
      this.city,
      this.uf});

  PointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    whatsapp = json['whatsapp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['whatsapp'] = this.whatsapp;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['uf'] = this.uf;
    return data;
  }
}
