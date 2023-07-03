// Fichier : lib/main.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/views/FindAllStations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stations de Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FindAllStations(),
    );
  }
}



