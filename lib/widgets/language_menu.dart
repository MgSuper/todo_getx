import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/controllers/locale_controller.dart';

class LanguageMenu extends GetView<LocaleController> {
  final localeController = Get.find<LocaleController>();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.language,
        color: Colors.black,
      ),
      offset: Offset(0, 40),
      itemBuilder: (context) =>
          localeController.optionsLocales.entries.map((item) {
        return PopupMenuItem(
          value: item.key,
          child: Text(item.value['description']),
        );
      }).toList(),
      onSelected: (String newValue) {
        localeController.updateLocale(newValue);
      },
    );
  }
}
