import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  // 1. Static instance variable (private)
  static SharedPreferences? _instance;

  // 2. Private constructor to prevent external instantiation
  PrefsService._();

  static Future<void> initialise() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    return _instance!;
  }
}
