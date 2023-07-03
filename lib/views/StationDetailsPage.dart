// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/models/mock_data.dart';


class StationDetailsPage extends StatelessWidget {
  final Station station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${station.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nom de la station : ${station.name}'),
            Text('Adresse : ${station.address}'),
            Text('Coordonnées : ${station.coordinates}'),
            // Ajoutez ici d'autres détails de la station-service.
          ],
        ),
      ),
    );
  }
}
