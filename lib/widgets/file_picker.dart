
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csv/csv.dart';


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
            child: IconButton(
              icon: const Icon(Icons.upload_file),
              tooltip: 'Upload .csv file',
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

// Only works for mobile since path_provider does not support web
// dart:io is not supported for web too, thus it's not possible to use "File"' variables
// fuc
// didn't find a way to do it on web still
Future<void> saveCSV(FilePickerResult? csvFile) async {
  if (csvFile != null) {
    String fileName = csvFile.files.first.name;

    String destinationPath = 'C:/flutter_projects/csv_importer/csv_importer/assets';
    print(destinationPath);

    // CSV binaries
    Uint8List fileBytes = csvFile.files.first.bytes!;

    // Get the local documents directory using path_provider
    String docPath = (await getApplicationDocumentsDirectory()).path;
    print(docPath);

    File toSave = File(csvFile.files.first.path!);
    final File savedFile = await toSave.copy('$docPath/$fileName');

    /* blocked because I'll probably remove this
    // Copy binaries 
    // Specify the destination file path within the folder
    String destinationFilePath = '$destinationPath/$fileName';

    // Create the file if it doesn't exist
    Directory(destinationFilePath).create(recursive: true);
    print(destinationFilePath);

    // Write the bytes to the new file
    await File(destinationFilePath).writeAsBytes(fileBytes);
    */

    print('File saved as $docPath/$fileName');
  } else {
    print('No file picked.');
  }
}

Future<void> CSVtoPython(FilePickerResult? csvFile) async {
  if (csvFile != null) {
    // Get File Bytes
    Uint8List? fileBytes = csvFile.files[0].bytes;
    if (fileBytes != null){
      // Decode bytes back to utf8
      final bytes = utf8.decode(fileBytes);
      // Convert utf8 data into List of Lists (2D array)
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(bytes);

      final url = Uri.parse('http://127.0.0.1:5000');
      String base64String = base64.encode(fileBytes);
      final requestData = {'binaryData': base64String};
      print('posting');
      // Send a POST request to the server
      final response = await http.post(
        url,
        body: jsonEncode(requestData),
      );
      // Handle the response from the server
      if (response.statusCode == 200) {
        print('Uint8List sent successfully.');
      } else {
        print('Failed to send Uint8List. Status code: ${response.statusCode}');
      }
      
    } else {
      // Handle the case when fileBytes is null
      print('fileBytes is null');
    }
  } else {
    // Handle the case when csvFile is null
     print('csvFile is null');
  }
}

// Not recommended to store complex and bigger values, thus not suitable for this project (shared_preferences)
// Maybe serialiaztion and deserialization works to larger values like maps and lists, will check on that
// Found a link that could help maybe?
// https://www.kodeco.com/5965747-data-persistence-on-flutter 
Future<void> storeCSV(FilePickerResult? csvFile) async{
  if(csvFile != null){
    Uint8List fileBytes = csvFile.files.first.bytes!;
    String fileName = csvFile.files.first.name;

    // mé
  }
} 


// Last idea is to use a database, like SQLite (?) or something