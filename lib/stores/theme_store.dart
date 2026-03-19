import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStore extends GetxController {
  static const String _keyThemeMode = 'theme_mode';

  final _isDarkMode = false.obs;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getBool(_keyThemeMode);
    if (themeMode == true) {
      _isDarkMode.value = true;
    } else {
      _isDarkMode.value = false;
    }
  }

  bool get isDarkMode => _isDarkMode.value;

  void setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeMode, isDarkMode);
    _isDarkMode.value = isDarkMode;
  }

  void toggleTheme() {
    setDarkMode(!isDarkMode);
  }
}
