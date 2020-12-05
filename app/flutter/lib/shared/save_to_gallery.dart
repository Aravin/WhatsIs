import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

Future<String> saveToGallery(File fileToSave) async {
  final appDir = await getApplicationDocumentsDirectory();
  String savePath = '${appDir.path}/status/images';
  String fileName = '';
  String result = '';

  if (!Directory(savePath).existsSync()) {
    Directory(savePath).createSync(recursive: true);
  }

  if (basename(fileToSave.path).split('.').length > 1) {
    fileName = '$savePath/${basename(fileToSave.path)}';
  } else {
    fileName =
        '$savePath/whatshub_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  if (File(fileName).existsSync()) {
    result = 'File Already Saved!';
    return result;
  }

  await File(fileToSave.path)
      .copy(fileName)
      .then((value) => result = 'Image Saved Successfully to Gallery!')
      .catchError(
        (onError) => result = onError.message.toString(),
      );

  return result;
}
