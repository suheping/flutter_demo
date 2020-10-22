import 'package:flutter/material.dart';

class WebViewProvider with ChangeNotifier {
  String _url = 'http://192.168.2.111:5500/lib/html/test1.html?params=';
  String _complateUrl;
  String get getUrl => _complateUrl;

  setParam(String params) {
    String _encodeParam = Uri.encodeComponent(Uri.encodeComponent(params));
    String url = _url + _encodeParam;
    _complateUrl = url;
    notifyListeners();
  }
}
