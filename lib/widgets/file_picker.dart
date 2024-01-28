import 'dart:async';

import 'package:csv_importer/widgets/functions/csv_to_python.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';



class filePickerWidget extends StatefulWidget {
  const filePickerWidget({super.key});

  @override
  State<filePickerWidget> createState() => _filePickerWidget();
}

// ignore: camel_case_types
class _filePickerWidget extends State<filePickerWidget> {

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(
          child: Center(
            child: ElevatedButton(
              child: Text(
                "Browse files".toUpperCase(),
                style: TextStyle(fontSize: 14)
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 77, 137, 155)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                )
              ),
              onPressed: () async {
                importCSV();
              },
            ),
          ), 
        ),
      ],
    );
  }
}

Future <void> importCSV() async{
  print('awaiting');

  try {
    // Pick file
    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
      allowMultiple: false,
    );

    if (csvFile != null) {
      await CSVtoPython(csvFile);
    } else {
      // Handle the case when the user cancels the file picker
      print('User canceled file picker');
    }
  } catch (e) {
    // Handle any exceptions that might occur during the file picker operation
    print('Error picking file: $e');
  } finally {
    // Hide loading indicator after file picker completes (success or failure)
    print('done');
  }
}
