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
          title: Text('Toutes les Stations', style: TextStyle(color: Color(0xFFffffff))),
          backgroundColor: Color(0xFF001931),
          bottom: TabBar(
            labelColor: Color(0xFFffffff),
            unselectedLabelColor: Color(0xFFffffff).withOpacity(0.5),
            indicatorColor: Color(0xFF001931),
            tabs: [
              Tab(text: 'Liste des stations'),
              Tab(text: 'Favoris'),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF001931)),
              ),
              child: DropdownButtonHideUnderline( // Pour cacher l'underline du DropdownButton
                child: DropdownButton<String>(
                  value: _selectedFuel,
                  items: <String>['Tous', 'Sans Plomb 98 (E5)', 'Sans Plomb 95 (E5)', 'Sans Plomb 95 (E10)', 'Gazole (B7)', 'Diesel'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Color(0xFF001931))),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFuel = newValue!;
                    });
                  },
                ),
              ),
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
    return ValueListenableBuilder(
      valueListenable: favoriteStations,
      builder: (context, value, child) {
        stations.sort((a, b) => (isFavorite(b) ? 1 : 0) - (isFavorite(a) ? 1 : 0));
        return ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            // Filtre les stations en fonction du carburant sélectionné
            if (_selectedFuel == 'Tous' || stations[index].fuels.any((fuel) => fuel.name == _selectedFuel)) {
              return Card( // Nouveau widget Card
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF001931), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(stations[index].name, style: TextStyle(color: Color(0xFF001931))),
                      if (isFavorite(stations[index]))
                        Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Adresse: ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${stations[index].address}\n', style: TextStyle(color: Color(0xFF001931))),
                        TextSpan(text: 'Longitude: ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${stations[index].longitude}\n', style: TextStyle(color: Color(0xFF001931))),
                        TextSpan(text: 'Latitude: ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${stations[index].latitude}', style: TextStyle(color: Color(0xFF001931))),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StationDetailsPage(station: stations[index]),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();  // Retourne un widget vide pour les stations qui ne correspondent pas au filtre
            }
          },
        );
      },
    );
  }

  bool isFavorite(Station station) {
    return favoriteStations.value.contains(station);
  }
}
