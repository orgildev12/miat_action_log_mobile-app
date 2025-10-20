import 'dart:ui';

import 'package:action_log_app/data/data_sources/language_code.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var languageCode = (Get.locale?.languageCode ?? 'mn').obs;

  void switchLocale() async{
    if (languageCode.value == 'mn') {
      languageCode.value = 'en';
      await saveLanguage(languageCode.value);
      Get.updateLocale(const Locale('en'));
    } else {
      languageCode.value = 'mn';
      await saveLanguage(languageCode.value);
      Get.updateLocale(const Locale('mn'));
    }
  }
}
