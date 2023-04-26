import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


const request = "http://api.hgbrasil.com/finance?format=json&key=89c06581";

void main() async{

  http.Response response = await http.get(Uri.parse(request));

  print(response.body);

  runApp(MaterialApp(
    home: Home()
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
      body: ,
    );
  }
}
