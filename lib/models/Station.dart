// To parse this JSON data, do
//
//     final stationFuel = stationFuelFromJson(jsonString);

import 'dart:convert';

List<StationFuel> stationFuelFromJson(String str) => List<StationFuel>.from(json.decode(str).map((x) => StationFuel.fromJson(x)));

String stationFuelToJson(List<StationFuel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StationFuel {
  final int idStation;
  final String address;
  final double latitude;
  final double longitude;
  final Brand brand;

  StationFuel({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.brand,
  });

  factory StationFuel.fromJson(Map<String, dynamic> json) => StationFuel(
    idStation: json["id_Station"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    brand: Brand.fromJson(json["brand"]),
  );

  Map<String, dynamic> toJson() => {
    "id_Station": idStation,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "brand": brand.toJson(),
  };
}

class Brand {
  final int idBrand;
  final String name;

  Brand({
    required this.idBrand,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    idBrand: json["id_Brand"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id_Brand": idBrand,
    "name": name,
  };
}
