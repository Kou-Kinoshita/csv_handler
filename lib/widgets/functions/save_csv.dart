// Only works for mobile since path_provider does not support web
// dart:io is not supported for web too, thus it's not possible to use "File"' variables
// fuc
// didn't find a way to do it on web still
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

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
