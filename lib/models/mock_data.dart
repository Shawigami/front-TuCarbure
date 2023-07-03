// Fichier : lib/models/mock_data.dart

import 'package:flutter/foundation.dart';

class Station {
  final String name;
  final String address;
  final String coordinates;

  Station({required this.name, required this.address, required this.coordinates});
}

final List<Station> mockStations = <Station>[
  Station(name: 'Station 1', address: 'Valenciennes', coordinates: 'Coordonnées 1'),
  Station(name: 'Station 2', address: 'Lens', coordinates: 'Coordonnées 2'),
  Station(name: 'Station 3', address: 'Lille', coordinates: 'Coordonnées 3'),
  Station(name: 'Station 4', address: 'Denain', coordinates: 'Coordonnées 4'),
  Station(name: 'Station 5', address: 'Arras', coordinates: 'Coordonnées 5'),
  // Ajoutez autant de stations que vous le souhaitez
];

final ValueNotifier<List<Station>> favoriteStations = ValueNotifier(<Station>[]);

