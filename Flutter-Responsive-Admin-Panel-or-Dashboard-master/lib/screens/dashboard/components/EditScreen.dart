import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String selectedRace = '';
  String selectedSpecies = '';
  String selectedStatus = '';

  List<String> races = ['Race 1', 'Race 2', 'Race 3'];
  List<String> species = ['Species 1', 'Species 2', 'Species 3'];
  List<String> status = ['Status 1', 'Status 2', 'Status 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedRace,
              onChanged: (value) {
                setState(() {
                  selectedRace = value!;
                });
              },
              items: races.map<DropdownMenuItem<String>>((String race) {
                return DropdownMenuItem<String>(
                  value: race,
                  child: Text(race),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Race',
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedSpecies,
              onChanged: (value) {
                setState(() {
                  selectedSpecies = value!;
                });
              },
              items: species.map<DropdownMenuItem<String>>((String specie) {
                return DropdownMenuItem<String>(
                  value: specie,
                  child: Text(specie),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Species',
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
              items: status.map<DropdownMenuItem<String>>((String stat) {
                return DropdownMenuItem<String>(
                  value: stat,
                  child: Text(stat),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Status',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform save operation
                // Here, you can access the selected values:
                // selectedRace, selectedSpecies, selectedStatus
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// ...

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Faça o processamento dos dados recebidos
    // ...
  } else {
    // Trate os erros da chamada da API
    print('Erro na chamada da API: ${response.statusCode}');
  }
}
