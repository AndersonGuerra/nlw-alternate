class PointDetailModel {
  Point point;
  List<Items> items;

  PointDetailModel({this.point, this.items});

  PointDetailModel.fromJson(Map<String, dynamic> json) {
    point = json['point'] != null ? new Point.fromJson(json['point']) : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.point != null) {
      data['point'] = this.point.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Point {
  int id;
  String image;
  String name;
  String email;
  String whatsapp;
  double latitude;
  double longitude;
  String city;
  String uf;

  Point(
      {this.id,
      this.image,
      this.name,
      this.email,
      this.whatsapp,
      this.latitude,
      this.longitude,
      this.city,
      this.uf});

  Point.fromJson(Map<String, dynamic> json) {
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

class Items {
  int id;
  String image;
  String title;
  int pointId;
  int itemId;

  Items({this.id, this.image, this.title, this.pointId, this.itemId});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    pointId = json['point_id'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['point_id'] = this.pointId;
    data['item_id'] = this.itemId;
    return data;
  }
}
