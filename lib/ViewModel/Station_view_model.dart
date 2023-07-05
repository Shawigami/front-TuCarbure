import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;

import '../models/Station.dart';

class StationAPI {

  static const String apiUrl = 'https://192.168.1.23:7033/Releve';

  Future<List<Station>> fetchInfoStations() async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Station>.from(
          jsonData.map((data) => Station.fromJson(data)));
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }
}

class Station {
  final int idStation;
  final String address;
  final String latitude;
  final String longitude;

  const Station({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      idStation: json["id_Station"],
      address: json["address"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
    );
  }
}
