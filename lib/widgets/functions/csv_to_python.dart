import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

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
      var http;
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
