import 'dart:js';

import 'package:flutter/material.dart';

import '../screens/dashboard/components/EditScreen.dart';

class RecentFile {
  final String? icon, title, species;
  final bool status;
  final Widget actionsButton;

  RecentFile({
    this.icon,
    this.title,
    this.species,
    required this.status,
    required this.actionsButton,
  });
}

List<RecentFile> demoRecentFiles = [
  RecentFile(
    icon: "assets/images/labrador.svg",
    title: "Labrador Retriever",
    species: "Cachorro",
    status: false,
    actionsButton: Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditScreen()),
            );
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () {
            // Lógica para ação de excluir
          },
          icon: Icon(Icons.delete),
        ),
        Spacer(),
      ],
    ),
  ),
];

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Icon')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Species')),
            DataColumn(label: Text('Actions')),
            DataColumn(label: Text('Status')),
          ],
          rows: demoRecentFiles.map((file) {
            return DataRow(cells: [
              DataCell(Image.asset(file.icon!)),
              DataCell(Text(file.title!)),
              DataCell(Text(file.species!)),
              DataCell(file.actionsButton),
              DataCell(Switch(
                value: file.status,
                onChanged: (value) {
                  // Lógica para atualizar o status
                },
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
