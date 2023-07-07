import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tucarbure/models/StationFuel.dart';
import 'package:tucarbure/views/StationDetailsPage.dart';
import 'package:tucarbure/ViewModel/StationFuelViewModel.dart';
import 'package:tucarbure/ViewModel/StatementViewModel.dart';
import 'package:tucarbure/ViewModel/StationViewModel.dart';

import '../models/Statement.dart';

class FindAllStations extends StatefulWidget {
  @override
  _FindAllStationsState createState() => _FindAllStationsState();
}

class _FindAllStationsState extends State<FindAllStations> {
  String _selectedFuel = 'Tous';  // Nouvelle variable d'état pour le carburant sélectionné


  var viewmodel = StationFuelAPI();
  ValueNotifier<List<StationFuel>> stationFuels = ValueNotifier<List<StationFuel>>([]);

  void _fetchStationFuels() async {
    stationFuels = await viewmodel.fetchInfoStationFuels();
  }


  var viewmodelstatement = StatementAPI();
  late ValueListenable<List<Statement>> statements;

  void _fetchInfoStatements() async{
    var newStatements = await viewmodelstatement.fetchInfoStatements();
    setState(() {
      statements = newStatements;
    });
  }


  @override
  void initState() {
    _fetchStationFuels();
    _fetchInfoStatements();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toutes les Stations', style: TextStyle(color: Color(0xFFffffff))),
          backgroundColor: Color(0xFF001931),
          bottom: TabBar(
            labelColor: Color(0xFFffffff),
            unselectedLabelColor: Color(0xFFffffff).withOpacity(0.5),
            indicatorColor: Color(0xFF001931),
            tabs: [
              Tab(text: 'Liste des stations')
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
                    valueListenable: stationFuels,
                    builder: (context, value, child) {
                      return _buildStationsList(stationFuels);
                    },
                  ),
                  //ValueListenableBuilder(
                    //valueListenable: favoriteStations,
                   // builder: (context, value, child) {
                     // return _buildStationsList(favoriteStations.value);
                   // },
                  //),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationsList(ValueListenable<List<StationFuel>> stationFuels) {
    return ValueListenableBuilder(
      valueListenable: stationFuels,
      builder: (context, value, child) {
        //stationFuels.sort((a, b) => (isFavorite(b) ? 1 : 0) - (isFavorite(a) ? 1 : 0));
        return ListView.builder(
          itemCount: stationFuels.value.length,
          itemBuilder: (context, index) {
            // Filtre les stations en fonction du carburant sélectionné
            if (_selectedFuel == 'Tous') {
              return Card( // Nouveau widget Card
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF001931), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(stationFuels.value[index].station.address, style: TextStyle(color: Color(0xFF001931))),
                     //if (isFavorite(stationFuels[index] as Station))
                       // Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Date mise à jour : ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${statements.value[index].dateTimeStatement}\n', style: TextStyle(color: Color(0xFF001931))),
                        TextSpan(text: 'Price : ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${statements.value[index].price} €\n', style: TextStyle(color: Color(0xFF001931))),
                        TextSpan(text: 'Distance : ', style: TextStyle(color: Color(0xFFEF7300))),
                        TextSpan(text: '${"10 km"}', style: TextStyle(color: Color(0xFF001931))),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StationDetailsPage(station: stationFuels.value[index]),
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

  //bool isFavorite(Station station) {
  //  return favoriteStations.value.contains(station);
  //}
}
