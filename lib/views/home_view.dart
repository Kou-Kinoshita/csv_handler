import 'package:csv_importer/widgets/file_picker.dart';
import 'package:flutter/material.dart';

      
// ignore: camel_case_types
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePage();
}

// ignore: camel_case_types
class _homePage extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            filePickerWidget(),
          ],
        ),
      ),
    );
  }
}