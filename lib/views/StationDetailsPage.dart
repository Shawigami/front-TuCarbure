import 'package:flutter/material.dart';
import 'package:tucarbure/models/Station.dart';

class StationDetailsPage extends StatefulWidget {
  final Station station;

  StationDetailsPage({Key? key, required this.station}) : super(key: key);

  @override
  _StationDetailsPageState createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  late TextEditingController priceController;

  Statement statement = Statement(idStatement: 1, price: 1.3, dateTimeStatement: DateTime.now());

  void openPriceDialog(BuildContext context) async {
    double? newPrice = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController priceController = TextEditingController();

        return AlertDialog(
          title: Text('Change Price'),
          content: TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                double? updatedPrice =
                double.tryParse(priceController.text);
                Navigator.of(context).pop(updatedPrice);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newPrice != null) {
      setState(() {
        statement.price = newPrice;
        statement.dateTimeStatement = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Name'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => openPriceDialog(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fuel name: this is the fuel name',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Price: ${statement.price}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Text(
                'Date: ${statement.dateTimeStatement.toString()}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
