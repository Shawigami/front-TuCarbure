// Fichier : lib/views/FindAllStations.dart

import 'package:flutter/material.dart';
import 'package:tucarbure/models/mock_data.dart';
import 'package:tucarbure/views/StationDetailsPage.dart';

class FindAllStations extends StatefulWidget {
  @override
  _FindAllStationsState createState() => _FindAllStationsState();
}

class _FindAllStationsState extends State<FindAllStations> {
  String _selectedFuel = 'Tous';  // Nouvelle variable d'état pour le carburant sélectionné

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
        body: Column(
          children: [
            DropdownButton<String>(  // Nouveau widget DropdownButton pour le menu déroulant
              value: _selectedFuel,
              items: <String>['Tous', 'Sans Plomb 98 (E5)', 'Sans Plomb 95 (E5)', 'Sans Plomb 95 (E10)', 'Gazole (B7)', 'Diesel'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFuel = newValue!;
                });
              },
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ValueListenableBuilder(
                    valueListenable: stations,
                    builder: (context, value, child) {
                      return _buildStationsList(stations.value);
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: favoriteStations,
                    builder: (context, value, child) {
                      return _buildStationsList(favoriteStations.value);
                    },
                  ),
                ],
              ),
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
        // Filtre les stations en fonction du carburant sélectionné
        if (_selectedFuel == 'Tous' || stations[index].fuels.any((fuel) => fuel.name == _selectedFuel)) {
          return ListTile(
            title: Text(stations[index].name),
            subtitle: Text('Adresse: ${stations[index].address}\nLongitude: ${stations[index].longitude}\nLatitude: ${stations[index].latitude}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationDetailsPage(station: stations[index]),
                ),
              );
            },
          );
        } else {
          return Container();  // Retourne un widget vide pour les stations qui ne correspondent pas au filtre
        }
      },
    );
  }
}




