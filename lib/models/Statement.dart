// To parse this JSON data, do
//
//     final statement = statementFromJson(jsonString);

import 'dart:convert';

List<Statement> statementFromJson(String str) => List<Statement>.from(json.decode(str).map((x) => Statement.fromJson(x)));

String statementToJson(List<Statement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Statement {
  final int idStatement;
  final DateTime dateTimeStatement;
  final double price;
  final Station station;
  final Fuel fuel;

  Statement({
    required this.idStatement,
    required this.dateTimeStatement,
    required this.price,
    required this.station,
    required this.fuel,
  });

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
    idStatement: json["id_Statement"],
    dateTimeStatement: DateTime.parse(json["dateTimeStatement"]),
    price: json["price"]?.toDouble(),
    station: Station.fromJson(json["station"]),
    fuel: Fuel.fromJson(json["fuel"]),
  );

  Map<String, dynamic> toJson() => {
    "id_Statement": idStatement,
    "dateTimeStatement": dateTimeStatement.toIso8601String(),
    "price": price,
    "station": station.toJson(),
    "fuel": fuel.toJson(),
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
