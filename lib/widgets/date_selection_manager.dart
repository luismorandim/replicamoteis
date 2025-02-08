import 'package:flutter/material.dart';

class DateSelectionManager extends ChangeNotifier {
  String _selectedPeriod = "-- - --";

  String get selectedPeriod => _selectedPeriod;

  void updatePeriod(String newPeriod) {
    _selectedPeriod = newPeriod;
    notifyListeners();
  }

  void resetPeriod() {
    _selectedPeriod = "-- - --";
    notifyListeners();
  }
}
