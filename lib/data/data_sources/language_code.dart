import 'package:shared_preferences/shared_preferences.dart';

// Save language
Future<void> saveLanguage(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  print('saving: $languageCode');
  await prefs.setString('language_code', languageCode);
  print('saved: $languageCode');
}

// Load language
Future<String> loadLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final String? bruh = prefs.getString('language_code');
  print('used: $bruh');
  return prefs.getString('language_code') ?? 'mn'; // default to Mongolian
  
}
