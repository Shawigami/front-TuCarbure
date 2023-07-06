import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;

import '../models/StationFuel.dart';

class StationFuelAPI {
  List<StationFuel> stationFuels = [];
  static const String apiUrl = 'http://192.168.79.64:7026/api/Station';

  Future<ValueNotifier<List<StationFuel>>> fetchInfoStationFuels() async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      stationFuels = List<StationFuel>.from(
          jsonData.map((data) => StationFuel.fromJson(data)));
      ValueNotifier<List<StationFuel>> stations = ValueNotifier<List<StationFuel>>(
        stationFuels
      );
      print(stationFuels);
      return stations;
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }
}