// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/Station.dart';

import '../ViewModel/Station_view_model.dart';

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

  List<Station> stations = [];
  var isLoaded = false;


  getData() async {
    stations = await StationAPI().fetchInfoStations();
    if (stations != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Détails de ${widget.station.brand.name}',
        style: TextStyle(color: Color(0xFFffffff))),
        backgroundColor: Color(0xFF001931),
        ),
      body: Center(
    child: Column(
    children: [
    Card(
    // Nouveau widget Card
    shape: RoundedRectangleBorder(
    side: BorderSide(color: Color(0x00000000), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
    title: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('${widget.station.fuel.name}',
    style: TextStyle(color: Color(0xFF001931))),
      Text('${widget.station.statement.dateTimeStatement}', style: TextStyle(color: Color(0xFF001931))),

      ],

    ),

    ),
    )]
    ),
    ),
    );

  }

      }