

class Station {
  final int idStation;
  final String address;
  final double latitude;
  final double longitude;
  final Brand brand;
  final Fuel fuel;
  final Statement statement;

  const Station({
    required this.idStation,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.brand,
    required this.fuel,
    required this.statement,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      Station(
        idStation: json["id_Station"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        brand: Brand.fromJson(json["brand"]),
        fuel: Fuel.fromJson(json["fuel"]),
        statement: Statement.fromJson(json["statement"]),
      );
}

class Statement {
  int idStatement;
  DateTime dateTimeStatement;
  double price;

  Statement({
    required this.idStatement,
    required this.dateTimeStatement,
    required this.price,
  });

  factory Statement.fromJson(Map<String, dynamic> json) =>
      Statement(
        idStatement: json["id_Statement"],
        dateTimeStatement: DateTime.parse(json["dateTimeStatement"]),
        price: json["price"]?.toDouble(),
      );
}

class Fuel {
  int idFuel;
  String name;
  String codeEuro;

  Fuel({
    required this.idFuel,
    required this.name,
    required this.codeEuro,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) =>
      Fuel(
        idFuel: json["id_Fuel"],
        name: json["name"],
        codeEuro: json["codeEuro"],
      );
}

class Brand {
  int idBrand;
  String name;

  Brand({
    required this.idBrand,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(
        idBrand: json["id_Brand"],
        name: json["name"],
      );
}


