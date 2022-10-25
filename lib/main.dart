import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/controllers/locale_controller.dart';
import 'package:getx_learn/controllers_binding.dart';
import 'package:getx_learn/core/utils/locale_string.dart';
import 'package:getx_learn/data/services/storage/storage_service.dart';
import 'package:getx_learn/screens/screens.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

// main
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _locale = Get.put(LocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      translations: LocaleString(),
      locale: _locale.getLocale() == 'MM'
          ? Locale('my', 'MM')
          : Locale('en', 'US'), // Not Get.deviceLocale
      fallbackLocale: Locale('en', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.specialEliteTextTheme(),
      ),
      home: const HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
