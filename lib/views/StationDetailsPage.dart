// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/Statement.dart';

import '../ViewModel/StationViewModel.dart';
import '../models/Statement.dart';
import '../models/Station.dart';
import '../models/StationFuel.dart';

class StationDetailsPage extends StatefulWidget {
  final StationFuel station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  late TextEditingController _priceController;



  var viewmodelstation = StationAPI();
  late ValueListenable<List<StationAll>> stations;

  void _fetchInfoStations() async {
    stations = (await viewmodelstation.fetchInfoStations()) as ValueListenable<List<StationAll>>;
  }


  @override
  void initState() {
    _fetchInfoStations();
    super.initState();
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
        title: Text('Détails de ${widget.station.brand.name}', style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: Color(0xFF001931),
        actions: <Widget>[
          Tooltip(
            message: "Ajouter la Station au Favoris",
            child: IconButton(
              onPressed: null,
              icon: Icon(
                //isFavorite(widget.station) ? Icons.star : Icons.star_border,
                Icons.star,
                //color: Colors.yellow,
              ),
              //onPressed: () {
                //toggleFavorite(widget.station);
              //},
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Text("coucou")
        ],
      ),
    );
  }

  //bool isFavorite(Station station) {
  //  return favoriteStations.value.contains(station);
  //}


}
