// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/Statement.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import '../ViewModel/StatementViewModel.dart';
import '../ViewModel/StationViewModel.dart';
import '../models/Statement.dart';
import '../models/Station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../models/StationFuel.dart';

class StationDetailsPage extends StatefulWidget {
  final StationFuel station;

  const StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  late TextEditingController _priceController;

  var viewmodelstatement = StatementAPI();
  ValueNotifier<Statement> statements = ValueNotifier<Statement>(new Statement(idStatement: null, dateTimeStatement: null, price: null, station: null, fuel: null));

  void _fetchInfoStatements() async {
    var statementsFetched = await viewmodelstatement.fetchInfoStatementsById(widget.station.station.idStation);
    setState(() {
      statements = statementsFetched;
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchInfoStatements();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _openGoogleMapsIntent(BuildContext context) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${widget.station.station.latitude},${widget.station.station.longitude}';
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(url),
      package: 'com.google.android.apps.maps',
    );

    try {
      await intent.launch();
    } catch (e) {
      // Vous pouvez remplacer ceci par une gestion d'erreur personnalisÃ©e
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${widget.station.brand.name}', style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: Color(0xFF001931),
        actions:
        <Widget>[
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

      body: Column(

        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nom de carburant : ${statements.value.fuel?.name} (${statements.value.fuel?.codeEuro})', style: TextStyle(color: Color(0xFF001931))),
                //if (isFavorite(stationFuels[index] as Station))
                // Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Date mise à jour : ', style: TextStyle(color: Color(0xFFEF7300))),
                  TextSpan(text: '${DateFormat('dd / MM / y').format(statements.value.dateTimeStatement!) }\n', style: TextStyle(color: Color(0xFF001931))),
                  TextSpan(text: 'Price : ', style: TextStyle(color: Color(0xFFEF7300))),
                  TextSpan(text: '${statements.value.price} €\n', style: TextStyle(color: Color(0xFF001931))),
                  TextSpan(text: 'Distance : ', style: TextStyle(color: Color(0xFFEF7300))),
                  TextSpan(text: '${"10 km"}', style: TextStyle(color: Color(0xFF001931))),
                ],
              ),
            ),
          ),
      Expanded(
      child: Container(
      decoration: BoxDecoration(
      border: Border.all(
      color: Colors.grey[300]!,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: FlutterMap(
    options: MapOptions(
    center: LatLng(widget.station.station.latitude, widget.station.station.longitude),
    zoom: 17.50,
    ),

    ),
    ),
    ),

    ),
          FloatingActionButton.extended(
            onPressed: () => _openGoogleMapsIntent(context),
            label: Text('Ouvrir dans Google Maps'),
            icon: Icon(Icons.map),
            backgroundColor: Color(0xFF001931),
          )
    ],

      ),

    );
    
  }

  
    //bool isFavorite(Station station) {
    //  return favoriteStations.value.contains(station);
    //}

  }
