// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

List<Station> stationFromJson(String str) => List<Station>.from(json.decode(str).map((x) => Station.fromJson(x)));

String stationToJson(List<Station> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Station {
  final int idStation;
  final String address;
  final double latitude;
  final double longitude;
  final Brand brand;
  final Fuel fuel;
  final Statement statement;

  Station({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.brand,
    required this.fuel,
    required this.statement,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    idStation: json["id_Station"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    brand: Brand.fromJson(json["brand"]),
    fuel: Fuel.fromJson(json["fuel"]),
    statement: Statement.fromJson(json["statement"]),
  );

  Map<String, dynamic> toJson() => {
    "id_Station": idStation,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "brand": brand.toJson(),
    "fuel": fuel.toJson(),
    "statement": statement.toJson(),
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

class Statement {
  final int idStatement;
  late final DateTime dateTimeStatement;
  late final double price;

  Statement({
    required this.idStatement,
    required this.dateTimeStatement,
    required this.price,
  });

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
    idStatement: json["id_Statement"],
    dateTimeStatement: DateTime.parse(json["dateTimeStatement"]),
    price: json["price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id_Statement": idStatement,
    "dateTimeStatement": dateTimeStatement.toIso8601String(),
    "price": price,
  };
}
