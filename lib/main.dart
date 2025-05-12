import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MeasuresConverter(title: 'Measures Converter'),
    );
  }
}

class MeasuresConverter extends StatefulWidget {
  const MeasuresConverter({super.key, required this.title});

  final String title;

  @override
  State<MeasuresConverter> createState() => _MeasuresConverterState();
}

class _MeasuresConverterState extends State<MeasuresConverter> {
  // Input value controller
  final TextEditingController _valueController = TextEditingController();

  // Available units for conversion
  final List<String> _units = [
    'meters',
    'feet',
    'kilometers',
    'miles',
    'kilograms',
    'pounds',
    'liters',
    'gallons',
    'celsius',
    'fahrenheit'
  ];

  // Selected units
  String _fromUnit = 'meters';
  String _toUnit = 'feet';

  // Result of conversion
  String _result = '';

  // Perform the conversion
  void _convert() {
    // Get the input value
    double? value = double.tryParse(_valueController.text);

    if (value == null) {
      setState(() {
        _result = 'Please enter a valid number';
      });
      return;
    }

    // Convert to base unit
    double baseValue = _convertToBaseUnit(value, _fromUnit);

    // Convert from base unit to target unit
    double resultValue = _convertFromBaseUnit(baseValue, _toUnit);

    setState(() {
      _result = '${value.toString()} $_fromUnit are ${resultValue.toStringAsFixed(3)} $_toUnit';
    });
  }

  // Convert from the given unit to the base unit
  double _convertToBaseUnit(double value, String unit) {
    switch (unit) {
    // Length
      case 'meters': return value; // Base unit for length
      case 'feet': return value * 0.3048;
      case 'kilometers': return value * 1000;
      case 'miles': return value * 1609.34;

    // Weight
      case 'kilograms': return value; // Base unit for weight
      case 'pounds': return value * 0.453592;

    // Volume
      case 'liters': return value; // Base unit for volume
      case 'gallons': return value * 3.78541;

    // Temperature
      case 'celsius': return value; // Base unit for temperature
      case 'fahrenheit': return (value - 32) * 5/9;

      default: return value;
    }
  }

  // Convert from the base unit to the given unit
  double _convertFromBaseUnit(double baseValue, String unit) {
    switch (unit) {
    // Length
      case 'meters': return baseValue; // Base unit for length
      case 'feet': return baseValue / 0.3048;
      case 'kilometers': return baseValue / 1000;
      case 'miles': return baseValue / 1609.34;

    // Weight
      case 'kilograms': return baseValue; // Base unit for weight
      case 'pounds': return baseValue / 0.453592;

    // Volume
      case 'liters': return baseValue; // Base unit for volume
      case 'gallons': return baseValue / 3.78541;

    // Temperature
      case 'celsius': return baseValue; // Base unit for temperature
      case 'fahrenheit': return baseValue * 9/5 + 32;

      default: return baseValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Value input field
            const Text(
              'Value',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter value',
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            const SizedBox(height: 20),

            // From unit dropdown
            const Text(
              'From',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _fromUnit,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // To unit dropdown
            const Text(
              'To',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _toUnit,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Convert button
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),

            // Result text
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _valueController.dispose();
    super.dispose();
  }
}
