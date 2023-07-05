import 'package:flutter/material.dart';
import 'package:tucarbure/ViewModel/Station_view_model.dart';
import 'package:tucarbure/models/Station.dart';
import 'package:tucarbure/views/StationDetailsPage.dart';

//import '../models/mock_data.dart';

class FindAllStations extends StatefulWidget {
  @override
  _FindAllStationsState createState() => _FindAllStationsState();
}

class _FindAllStationsState extends State<FindAllStations> {
  String _selectedFuel = 'Tous';  // Nouvelle variable d'état pour le carburant sélectionné
  List<Station> stations = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // fetch data from API
    getData();
  }

  getData() async{
    stations = await StationAPI().fetchInfoStations();
    if(stations != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Toutes les Stations', style: TextStyle(color: Color(0xFFffffff))),
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
        body: Visibility (
          visible: isLoaded,
        child : ListView.builder(
          itemCount: stations?.length,
          itemBuilder: (context, index){
          return Container(
            child: Text(stations![index].address),
          );
        },
    ),
      )));
      }
}
