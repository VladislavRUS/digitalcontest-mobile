class Geo {
  double lat;
  double lng;

  Geo.fromJson(map) {
    lat = map['lat'];
    lng = map['lng'];
  }
}
