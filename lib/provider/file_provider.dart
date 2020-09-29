import 'package:flutter/material.dart';

class FileProvider with ChangeNotifier {
  String _filePath = '';
  String get filePath => _filePath;

  void setFilePath(String filePath) {
    _filePath = filePath;
    notifyListeners();
  }
}
