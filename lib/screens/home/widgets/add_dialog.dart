import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/controllers/home_controller.dart';

class AddDialog extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: ctrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        ctrl.editingController.clear();
                        ctrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (ctrl.formKey.currentState!.validate()) {
                          if (ctrl.task.value == null) {
                            EasyLoading.showError('Please select task type');
                          } else {
                            var success = ctrl.updateTask(
                                ctrl.task.value!, ctrl.editingController.text);
                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              ctrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist');
                            }
                            ctrl.editingController.clear();
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Text(
                  'New Task',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: TextFormField(
                  controller: ctrl.editingController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 3.0.wp, left: 7.0.wp, right: 7.0.wp, bottom: 3.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...ctrl.tasks
                  .map(
                    (e) => Obx(
                      () => InkWell(
                        onTap: () => ctrl.changeTask(e),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.0.wp,
                            vertical: 3.0.wp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      e.icon,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    color: HexColor.fromHex(e.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (ctrl.task.value == e)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
