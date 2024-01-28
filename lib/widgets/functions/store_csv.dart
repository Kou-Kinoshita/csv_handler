// Not recommended to store complex and bigger values, thus not suitable for this project (shared_preferences)
// Maybe serialiaztion and deserialization works to larger values like maps and lists, will check on that
// Found a link that could help maybe?
// https://www.kodeco.com/5965747-data-persistence-on-flutter 
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<void> storeCSV(FilePickerResult? csvFile) async{
  if(csvFile != null){
    Uint8List fileBytes = csvFile.files.first.bytes!;
    String fileName = csvFile.files.first.name;

    // mé
  }
} 
