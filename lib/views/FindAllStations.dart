// Fichier : lib/views/FindAllStations.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/models/mock_data.dart';
import 'package:tucarbure/views/StationDetailsPage.dart';

class FindAllStations extends StatefulWidget {
  @override
  _FindAllStationsState createState() => _FindAllStationsState();
}

class _FindAllStationsState extends State<FindAllStations> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toutes les Stations'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Liste des stations'),
              Tab(text: 'Favoris'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStationsList(mockStations),
            ValueListenableBuilder(
              valueListenable: favoriteStations,
              builder: (context, value, child) {
                return _buildStationsList(favoriteStations.value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationsList(List<Station> stations) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(stations[index].name),
          subtitle: Text('Adresse: ${stations[index].address}\nCoordonnées: ${stations[index].coordinates}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StationDetailsPage(station: stations[index]),
              ),
            );
          },
        );
      },
    );
  }
}



