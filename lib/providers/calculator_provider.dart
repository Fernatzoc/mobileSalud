import 'package:flutter/cupertino.dart';

class Calculator extends ChangeNotifier {
  String _dateSelected = '';

  String get dateSelected => _dateSelected;

  set dateSelected(String value) {
    _dateSelected = value;
    notifyListeners();
  }
}
