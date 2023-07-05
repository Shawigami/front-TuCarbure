// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/mock_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

class StationDetailsPage extends StatefulWidget {
  final Station station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _openGoogleMapsIntent(BuildContext context) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${widget.station.latitude},${widget.station.longitude}';
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(url),
      package: 'com.google.android.apps.maps',
    );

    try {
      await intent.launch();
    } catch (e) {
      // Vous pouvez remplacer ceci par une gestion d'erreur personnalisée
      print('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${widget.station.name}', style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: Color(0xFF001931),
        actions: <Widget>[
          Tooltip(
            message: "Ajouter la Station au Favoris",
            child: IconButton(
              icon: Icon(
                isFavorite(widget.station) ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              ),
              onPressed: () {
                toggleFavorite(widget.station);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                    center: LatLng(widget.station.latitude, widget.station.longitude),
                    zoom: 17.50,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      // Notez qu'il n'y a pas de paramètre 'userAgentPackageName' dans TileLayerOptions
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(widget.station.latitude, widget.station.longitude),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () => _openGoogleMapsIntent(context),
            label: Text('Ouvrir dans Google Maps'),
            icon: Icon(Icons.map),
            backgroundColor: Color(0xFF001931),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              for (var fuel in widget.station.fuels) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF001931), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('${fuel.name} - \$${fuel.price.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFF001931))),
                    subtitle: Text('Dernière mise à jour : ${DateFormat('dd/MM/yyyy').format(fuel.lastUpdate)}', style: TextStyle(color: Color(0xFFEF7300))),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Color(0xFF001931)),
                      onPressed: () => _showFuelEditDialog(context, fuel),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
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

  void _showFuelEditDialog(BuildContext context, Fuel fuel) {
    _priceController.text = fuel.price.toStringAsFixed(2);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: Color(0xFF001931), width: 2),
        ),
        title: Text('Modifier le prix du ${fuel.name}', style: TextStyle(color: Color(0xFF001931))),
        content: TextField(
          controller: _priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Prix',
            labelStyle: TextStyle(color: Color(0xFF001931)),
            helperText: 'Entrez un prix entre 1.00 et 2.50',
            helperStyle: TextStyle(color: Color(0xFF001931)),
          ),
          style: TextStyle(color: Color(0xFF001931)),
        ),
        actions: [
          TextButton(
            child: Text('ANNULER', style: TextStyle(color: Color(0xFF001931))),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('VALIDER', style: TextStyle(color: Color(0xFF001931))),
            onPressed: () {
              double newPrice = double.tryParse(_priceController.text) ?? fuel.price;
              if (newPrice < 1.0 || newPrice > 2.5) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Le prix doit être entre 1.00 et 2.50'),
                  backgroundColor: Colors.red,
                ));
              } else {
                setState(() {
                  fuel.price = newPrice;
                  fuel.lastUpdate = DateTime.now();
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}