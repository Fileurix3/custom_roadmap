import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool("darkTheme") ?? false;
    _isLoading = false;
    notifyListeners();
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkTheme", _darkTheme);
  }
}
