import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPreferences {
  static final SPreferences _instance = SPreferences._privateConstructor();

  SharedPreferences? _sharedPreferences;

  SPreferences._privateConstructor();

  factory SPreferences() {
    return _instance;
  }

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("initialized preferences");
    }
  }

  Future<SharedPreferences> get prefs async {
    if (_sharedPreferences == null) {
      await init();
    }
    return _sharedPreferences!;
  }
}
