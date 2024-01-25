import 'package:csv_importer/views/home_view.dart';
import 'package:flutter/material.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      //appBar: ,
      home: homePage(),
    );
  }
}
