import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  AppTheme() : _isDark = false, _columnCount = 3 {
    _loadSettings();
  }

  bool get isDark => _isDark;
  bool _isDark;

  int get columnCount => _columnCount;
  int _columnCount;

  ThemeData buildTheme() => _isDark ? ThemeData.dark() : ThemeData.light();

  void changeMode() {
    _isDark = !_isDark;
    notifyListeners();
  }

  Future<void> setColumnCount(int count) async {
    _columnCount = count;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('columnCount', count);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _columnCount = prefs.getInt('columnCount') ?? 3;
    notifyListeners();
  }
}
