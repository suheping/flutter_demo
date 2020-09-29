import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;
  // get方法
  int get count => _count;

  // set方法
  void setCount(String option) {
    if (option == 'add') {
      _count++;
    } else if (option == 'reduce') {
      _count--;
    }
    notifyListeners();
  }
}
