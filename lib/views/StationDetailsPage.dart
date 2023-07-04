// Fichier : lib/views/StationDetailsPage.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'importer 'intl' pour utiliser DateFormat
import 'package:tucarbure/models/mock_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${widget.station.name}'),
      ),
      body: ListView(
        children: [
          // ...

          for (var fuel in widget.station.fuels) ...[
            ListTile(
              title: Text('${fuel.name} - \$${fuel.price.toStringAsFixed(2)}'),
              subtitle: Text('Dernière mise à jour : ${DateFormat('dd/MM/yyyy').format(fuel.lastUpdate)}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _showFuelEditDialog(context, fuel),
              ),
            ),
          ],

          IconButton(
            icon: Icon(
              isFavorite(widget.station) ? Icons.star : Icons.star_border,
            ),
            onPressed: () {
              toggleFavorite(widget.station);
            },
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
        title: Text('Modifier le prix du carburant'),
        content: TextField(
          controller: _priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Prix',
            helperText: 'Entrez un prix entre 1.00 et 2.50',
          ),
        ),
        actions: [
          TextButton(
            child: Text('ANNULER'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('VALIDER'),
            onPressed: () {
              double newPrice = double.tryParse(_priceController.text) ?? fuel.price;
              if (newPrice < 1.0 || newPrice > 2.5) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Le prix doit être entre 1.00 et 2.50'),
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


