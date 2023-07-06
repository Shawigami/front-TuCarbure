import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;

import '../models/Statement.dart';

class StatementAPI {
  List<Statement> statements = [];
  static const String apiUrl = 'http://192.168.79.64:7026/api/Statement';

  Future<ValueNotifier<List<Statement>>> fetchInfoStatements() async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      statements = List<Statement>.from(
          jsonData.map((data) => Statement.fromJson(data)));
      ValueNotifier<List<Statement>> Allstatements = ValueNotifier<List<Statement>>(
          statements
      );
      print(statements);
      return Allstatements;
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }

  Future<ValueNotifier<List<Statement>>> fetchInfoStatementsById(int id) async {
    // Créer un client HTTP en désactivant la vérification du certificat
    http.Client client = http_io.IOClient(
      HttpClient()..badCertificateCallback = (cert, host, port) => true,
    );

    final response = await client.get(Uri.parse(apiUrl+id.toString()));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      statements = List<Statement>.from(
          jsonData.map((data) => Statement.fromJson(data)));
      ValueNotifier<List<Statement>> Allstatements = ValueNotifier<List<Statement>>(
          statements
      );
      print(statements);
      return Allstatements;
    } else {
      throw Exception('Failed to fetch InfoCarbu from API');
    }
  }
}