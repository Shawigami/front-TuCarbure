// To parse this JSON data, do
//
//     final stationAll = stationAllFromJson(jsonString);

import 'dart:convert';

StationAll stationAllFromJson(String str) => StationAll.fromJson(json.decode(str));

String stationAllToJson(StationAll data) => json.encode(data.toJson());

class StationAll {
  final int idStation;
  final String address;
  final double latitude;
  final double longitude;
  final Brand brand;

  StationAll({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.brand,
  });

  factory StationAll.fromJson(Map<String, dynamic> json) => StationAll(
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
