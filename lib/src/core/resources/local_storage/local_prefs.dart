import "package:shared_preferences/shared_preferences.dart";

class LocalPrefs {
  LocalPrefs._();

  static const String _firstTimeKey = "firstTime";

  static late final SharedPreferences _prefs;

  static Future<void> initLocalPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static set firstTime(_) => _prefs.setBool(_firstTimeKey, true);
  static bool get firstTime => _prefs.getBool(_firstTimeKey) ?? false;
  static void removeFirstTime() {
    _prefs.remove(_firstTimeKey);
  }
}
