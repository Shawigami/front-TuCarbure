// To parse this JSON data, do
//
//     final stationFuel = stationFuelFromJson(jsonString);

import 'dart:convert';

StationFuel stationFuelFromJson(String str) => StationFuel.fromJson(json.decode(str));

String stationFuelToJson(StationFuel data) => json.encode(data.toJson());

class StationFuel {
  final int idStationFuel;
  final Station station;
  final Fuel fuel;
  final Brand brand;

  StationFuel({
    required this.idStationFuel,
    required this.station,
    required this.fuel,
    required this.brand,
  });

  factory StationFuel.fromJson(Map<String, dynamic> json) => StationFuel(
    idStationFuel: json["id_StationFuel"],
    station: Station.fromJson(json["station"]),
    fuel: Fuel.fromJson(json["fuel"]),
    brand: Brand.fromJson(json["brand"]),
  );

  Map<String, dynamic> toJson() => {
    "id_StationFuel": idStationFuel,
    "station": station.toJson(),
    "fuel": fuel.toJson(),
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

class Fuel {
  final int idFuel;
  final String name;
  final String codeEuro;

  Fuel({
    required this.idFuel,
    required this.name,
    required this.codeEuro,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) => Fuel(
    idFuel: json["id_Fuel"],
    name: json["name"],
    codeEuro: json["codeEuro"],
  );

  Map<String, dynamic> toJson() => {
    "id_Fuel": idFuel,
    "name": name,
    "codeEuro": codeEuro,
  };
}

class Station {
  final int idStation;
  final String address;
  final double latitude;
  final double longitude;
  final dynamic brand;

  Station({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.brand,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    idStation: json["id_Station"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "id_Station": idStation,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "brand": brand,
  };
}
