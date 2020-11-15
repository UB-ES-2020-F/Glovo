import 'dart:convert';
import 'package:flutter/services.dart';

String _defaultEnv = 'dev';

class AppConfig {
  final String apiUrl;
  AppConfig({this.apiUrl});

  static AppConfig _appConfig;

  static Future<AppConfig> getConfig() async {
    if (_appConfig == null) await setEnvironment(_defaultEnv);
    return _appConfig;
  }

  static Future<void> setEnvironment(String env) async {
    env = env ?? 'dev';
    final contents = await rootBundle.loadString(
      'resources/config/$env.json',
    );
    final json = jsonDecode(contents);
    _appConfig = AppConfig(apiUrl: json['apiUrl']);
  }
}
