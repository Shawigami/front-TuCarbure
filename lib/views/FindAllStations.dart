// Fichier : lib/views/FindAllStations.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/models/mock_data.dart';
import 'package:tucarbure/views/StationDetailsPage.dart';

class FindAllStations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toutes les Stations'),
      ),
      body: ListView.builder(
        itemCount: mockStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mockStations[index].name),
            subtitle: Text('Adresse: ${mockStations[index].address}\nCoordonnées: ${mockStations[index].coordinates}'),
            onTap: () {
              // Naviguez vers les détails de la station lorsque vous cliquez sur une station spécifique
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationDetailsPage(station: mockStations[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

