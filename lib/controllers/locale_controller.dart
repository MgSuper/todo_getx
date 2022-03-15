import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_learn/core/utils/keys.dart';
import 'package:getx_learn/data/services/storage/storage_service.dart';

class LocaleController extends GetxController {
  final _storage = Get.find<StorageService>();
  final RxString locale = Get.locale.toString().obs;

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'description': 'English'
    },
    'my_MM': {
      'languageCode': 'my',
      'countryCode': 'MM',
      'description': 'မြန်မာ'
    },
  };

  String getLocale() => _storage.read(localeKey) ?? '';

  void updateLocale(String key) {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    // Update storage
    _storage.write(localeKey, countryCode);
  }
}
