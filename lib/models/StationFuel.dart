// To parse this JSON data, do
//
//     final stationFuel = stationFuelFromJson(jsonString);

import 'dart:convert';

List<StationFuel> stationFuelFromJson(String str) => List<StationFuel>.from(json.decode(str).map((x) => StationFuel.fromJson(x)));

String stationFuelToJson(List<StationFuel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StationFuel {
    final int idStationFuel;
    final Station station;
    final Fuel fuel;

    StationFuel({
        required this.idStationFuel,
        required this.station,
        required this.fuel,
    });

    factory StationFuel.fromJson(Map<String, dynamic> json) => StationFuel(
        idStationFuel: json["id_StationFuel"],
        station: Station.fromJson(json["station"]),
        fuel: Fuel.fromJson(json["fuel"]),
    );

    Map<String, dynamic> toJson() => {
        "id_StationFuel": idStationFuel,
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
