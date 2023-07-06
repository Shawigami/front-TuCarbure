import 'package:flutter/material.dart';
import 'package:tucarbure/models/StationFuel.dart';
import 'package:tucarbure/models/Statement.dart';
import 'package:tucarbure/views/StationDetailsPage.dart'; // Remplacez par votre page de détails de station si vous en avez une

class FindAllStations extends StatefulWidget {
  @override
  _FindAllStationsState createState() => _FindAllStationsState();
}

class _FindAllStationsState extends State<FindAllStations> {
  String _selectedFuel = 'Tous';
  List<StationFuel> stations = []; // À remplacer par vos données réelles
  List<StationFuel> favoriteStations = []; // À remplacer par vos données réelles

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
              child: DropdownButtonHideUnderline(
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
                  _buildStationsList(stations),
                  _buildStationsList(favoriteStations),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationsList(List<StationFuel> stations) {
    stations.sort((a, b) => (isFavorite(b) ? 1 : 0) - (isFavorite(a) ? 1 : 0));
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        if (_selectedFuel == 'Tous' || stations[index].fuel.name == _selectedFuel) {
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xFF001931), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stations[index].station.brand.toString(), style: TextStyle(color: Color(0xFF001931))),
                  if (isFavorite(stations[index]))
                    Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Adresse: ', style: TextStyle(color: Color(0xFFEF7300))),
                    TextSpan(text: '${stations[index].station.address}\n', style: TextStyle(color: Color(0xFF001931))),
                    TextSpan(text: 'Longitude: ', style: TextStyle(color: Color(0xFFEF7300))),
                    TextSpan(text: '${stations[index].station.longitude}\n', style: TextStyle(color: Color(0xFF001931))),
                    TextSpan(text: 'Latitude: ', style: TextStyle(color: Color(0xFFEF7300))),
                    TextSpan(text: '${stations[index].station.latitude}', style: TextStyle(color: Color(0xFF001931))),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationDetailsPage(station: stations[index]), // Remplacez par votre page de détails de station si vous en avez une
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool isFavorite(StationFuel station) {
    return favoriteStations.contains(station);
  }
}
