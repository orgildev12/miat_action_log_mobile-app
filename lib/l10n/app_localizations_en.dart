// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get warning => 'Warning';

  @override
  String get weAreSorry => 'We\'re sorry';

  @override
  String get sorry => 'Sorry';

  @override
  String get description401 => 'Username or password is incorrect';

  @override
  String get description503 => 'This action is currently not possible. Please try again later.';

  @override
  String get description500 => 'Something went wrong. Please try again later.';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get noInternet => 'Check your internet connection';

  @override
  String get incorrectUserPass => 'Username or password is incorrect.';

  @override
  String get success => 'Success';

  @override
  String get connectionRecovered => 'Connection Recovered';
}
