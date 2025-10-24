import 'package:shared_preferences/shared_preferences.dart';

// Save language
Future<void> saveLanguage(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('language_code', languageCode);
}

// Load language
Future<String> loadLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('language_code') ?? 'mn'; // default to Mongolian
}