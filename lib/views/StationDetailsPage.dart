// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/models/mock_data.dart';

class StationDetailsPage extends StatefulWidget {
  final Station station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${widget.station.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Nom: ${widget.station.name}'),
            Text('Adresse: ${widget.station.address}'),
            Text('Coordonnées: ${widget.station.coordinates}'),
            IconButton(
              icon: Icon(
                isFavorite(widget.station) ? Icons.star : Icons.star_border,
              ),
              onPressed: () {
                toggleFavorite(widget.station);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isFavorite(Station station) {
    return favoriteStations.value.contains(station);
  }

  void toggleFavorite(Station station) {
    if (isFavorite(station)) {
      favoriteStations.value = List.from(favoriteStations.value)..remove(station);
    } else {
      favoriteStations.value = List.from(favoriteStations.value)..add(station);
    }
    setState(() {}); // Met à jour l'état du widget pour mettre à jour l'icône
  }
}

