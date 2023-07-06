import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'package:tucarbure/models/Station.dart';

import '../models/StationFuel.dart';

class StationAPI {
  List<StationAll> stations = [];
  static const String apiUrl = 'http://192.168.79.64:7026/api/Station';

  Future<ValueNotifier<List<StationAll>>> fetchInfoStations() async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      stations = List<StationAll>.from(
          jsonData.map((data) => Station.fromJson(data)));
      ValueNotifier<List<StationAll>> stationsAll = ValueNotifier<List<StationAll>>(
        stations
      );
      print(stations);
      return stationsAll;
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }
}