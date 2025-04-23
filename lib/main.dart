import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Unit Converter', home: UnitConverterScreen());
  }
}

class UnitConverterScreen extends StatefulWidget {
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  String _result = '';

  final Map<String, double> lengthUnits = {'Meters': 1.0, 'Kilometers': 1000.0};

  final Map<String, double> weightUnits = {'Grams': 1.0, 'Kilograms': 1000.0};

  String _conversionType = 'Length'; // or 'Weight'

  void _convert() {
    double? input = double.tryParse(_inputController.text);
    if (input == null) return;

    double result = 0.0;

    Map<String, double> units =
        _conversionType == 'Length' ? lengthUnits : weightUnits;

    result = input * (units[_fromUnit]! / units[_toUnit]!);

    setState(() {
      _result = '$input $_fromUnit = ${result.toStringAsFixed(3)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    final units = _conversionType == 'Length' ? lengthUnits : weightUnits;

    return Scaffold(
      appBar: AppBar(title: Text('Simple Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _conversionType,
              items:
                  ['Length', 'Weight']
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _conversionType = value!;
                  _fromUnit = units.keys.first;
                  _toUnit = units.keys.last;
                });
              },
            ),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter value'),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromUnit,
                    items:
                        units.keys
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        _fromUnit = value!;
                      });
                    },
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toUnit,
                    items:
                        units.keys
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        _toUnit = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: _convert, child: Text('Convert')),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
