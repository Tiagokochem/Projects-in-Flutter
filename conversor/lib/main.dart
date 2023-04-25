import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';


const request = "http://api.hgbrasil.com/finance?format=json&key=89c06581";

void main() async{

  http.Response response = await http.get(request as Uri);
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  print(response.body);

  runApp(MaterialApp(
    home: Container()
  ));
}