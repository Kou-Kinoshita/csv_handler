import 'package:csv_importer/widgets/functions/csv_to_python.dart';
import 'package:file_picker/file_picker.dart';

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