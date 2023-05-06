import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _toDoList = [];

  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newToDo = {
        "title": _toDoController.text,
        "ok": false,
      };
      _toDoController.text = "";
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return await file.readAsString();
    } catch (e) {
      print('Ocorreu um erro ao ler o arquivo: $e');
      return ''; // ou return [] para retornar uma lista vazia
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList[index]["ok"],
                  secondary: CircleAvatar(
                    child: Icon(
                        _toDoList[index]["ok"] ? Icons.check : Icons.error),
                  ),
                  onChanged: (c) {
                    setState(() {
                      _toDoList[index]["ok"] = c;
                      _saveData();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
