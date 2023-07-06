import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;

import '../models/Station.dart';

class StationAPI {
  List<Station> stations = [];
  static const String apiUrl = 'http://192.168.79.64:7026/api/Station';

  Future<List<Station>> fetchInfoStations() async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      stations = List<Station>.from(
          jsonData.map((data) => Station.fromJson(data)));
      print(stations);
      return stations;
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }

}
class UpdatePrice {
  Future<http.Response> updateStatement(Double price) {
    return http.post(
      Uri.parse('http://192.168.79.64:7026/api/Statement'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Double>{
        'price': price,
      }),
    );
  }
}
