import 'dart:convert';

import 'package:emdr_mindmend/src/features/splash/domain/models/credential_model.dart';
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

  // Save CredentialsModel to SharedPreferences
  Future<void> saveCredentials(CredentialsModel credentials) async {
    final prefs = await _instance.prefs;
    final credentialsJson = jsonEncode(credentials.toJson());
    prefs.setString('user_credentials', credentialsJson);
  }

  // Retrieve CredentialsModel from SharedPreferences
  Future<CredentialsModel?> getCredentials() async {
    final prefs = await _instance.prefs;
    final credentialsString = prefs.getString('user_credentials');
    if (credentialsString != null) {
      final json = jsonDecode(credentialsString);
      return CredentialsModel.fromJson(json);
    }
    return null;
  }

  // Clear CredentialsModel from SharedPreferences
  Future<void> clearCredentials() async {
    final prefs = await _instance.prefs;
    prefs.remove('user_credentials');
  }
}
