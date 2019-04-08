import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bookList.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      String books = await file.readAsString();
      return books;
    } catch (e) {
      // If we encounter an error, return 0
      return '[]';
    }
  }

  Future<File> write(String books) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$books');
  }
}

var store = Storage();
