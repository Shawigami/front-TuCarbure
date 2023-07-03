class Station {
  final String name;
  final String address;
  final String coordinates;

  Station(this.name, this.address, this.coordinates);
}

final List<Station> mockStations = <Station>[
  Station('Station 1', '123 Rue Polochon, Ville, 00000', '48.8566, 2.3522'),
  Station('Station 2', '456 Boulevard QuiSentLaPisse, Ville, 00000', '48.8576, 2.3623'),
  Station('Station 3', '789 Avenue Trouduc, Ville, 00000', '48.8586, 2.3724'),
];
