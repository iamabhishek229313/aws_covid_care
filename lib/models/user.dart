class User {
  String displayName;
  String email;
  String phoneNumber;
  Coords coord;

  User(this.displayName, this.email, this.phoneNumber, this.coord);

  User.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    coord = new Coords.fromJson(json['coord']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['coord'] = this.coord.toJson();
    return data;
  }
}

class Coords {
  String long;
  String lat;

  Coords(this.long, this.lat);

  Coords.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['lat'] = this.lat;
    return data;
  }
}
