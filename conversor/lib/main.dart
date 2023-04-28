import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "http://api.hgbrasil.com/finance?format=json&key=89c06581";

void main() async {
  http.Response response = await http.get(Uri.parse(request));
  runApp(MaterialApp(home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor\$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                  var euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                  
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget> [
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"
                          ),
                          style: TextStyle(
                            color: Colors.amber, fontSize: 25.0
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Dolares",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "U\$"
                          ),
                          style: TextStyle(
                              color: Colors.amber, fontSize: 25.0
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Euros",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "E\$"
                          ),
                          style: TextStyle(
                              color: Colors.amber, fontSize: 25.0
                          ),
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
