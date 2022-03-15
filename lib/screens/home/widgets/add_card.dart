import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_learn/constants/style.dart';
import 'package:getx_learn/core/values/colors.dart';
import 'package:getx_learn/data/models/task.dart';
import 'package:getx_learn/controllers/controllers.dart';
import 'package:getx_learn/widgets/icons.dart';
import 'package:getx_learn/core/utils/extensions.dart';

class AddCard extends StatelessWidget {
  final _ctrl = Get.find<HomeController>();
  final _locale = Get.find<LocaleController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5.0,
            title: 'task_type'.tr,
            content: Form(
              key: _ctrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      cursorHeight: 4.0.wp,
                      autofocus: true,
                      controller: _ctrl.editingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'task_title'.tr,
                        labelStyle: _locale.getLocale() == 'MM'
                            ? mAddCardTextStyle
                            : eAddCardTextStyle,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'task_title_confirm'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(() {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  label: e,
                                  selected: _ctrl.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    _ctrl.chipIndex.value =
                                        selected ? index : 0;
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minimumSize: const Size(150.0, 40.0),
                    ),
                    onPressed: () {
                      if (_ctrl.formKey.currentState!.validate()) {
                        int icon = icons[_ctrl.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[_ctrl.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: _ctrl.editingController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        _ctrl.addTask(task)
                            ? EasyLoading.showSuccess('task_create_success'.tr)
                            : EasyLoading.showError('task_duplicate'.tr);
                      }
                    },
                    child: Text('confirm'.tr),
                  ),
                ],
              ),
            ),
          );
          _ctrl.editingController.clear();
          _ctrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
