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
