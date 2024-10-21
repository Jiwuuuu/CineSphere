// navigation_state.dart
import 'package:flutter/material.dart';

class NavigationState with ChangeNotifier {
  int _selectedIndex = 1; // Default to Home

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
