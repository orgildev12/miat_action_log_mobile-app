// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get warning => 'Анхааруулга';

  @override
  String get weAreSorry => 'Уучлаарай';

  @override
  String get sorry => 'Уучлаарай';

  @override
  String get description401 => 'Username or password is incorrect';

  @override
  String get description503 => 'Энэ үйлдэл одоогоор боломжгүй байна. Дараа дахин оролдоно уу.';

  @override
  String get description500 => 'Алдаа гарлаа. Дараа дахин оролдоно уу.';

  @override
  String get loginSuccess => 'Амжилттай нэвтэрлээ';

  @override
  String get noInternet => 'Интернэт холболтоо шалгана уу';

  @override
  String get incorrectUserPass => 'Хэрэглэгчийн нэр эсвэл нууц үг буруу байна.';

  @override
  String get success => 'Амжилттай';

  @override
  String get connectionRecovered => 'Холболт сэргээгдлээ';
}
