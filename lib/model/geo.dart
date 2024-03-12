class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'], lng: json['lng']);
}
