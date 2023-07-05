// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/Station.dart';

class StationDetailsPage extends StatefulWidget {
  final Station station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${widget.station.brand.name}',
            style: TextStyle(color: Color(0xFFffffff))),
        backgroundColor: Color(0xFF001931),
        actions: <Widget>[

        ],
      ),
    );
  }
  }
