import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/screens/detail/widgets/in_progress_list.dart';
import 'package:getx_learn/screens/detail/widgets/on_done_list.dart';
import 'package:getx_learn/controllers/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Detail extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = ctrl.task.value!;
    var color = HexColor.fromHex(task.color);
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
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        ctrl.updateTodos();
                        ctrl.changeTask(null);
                        ctrl.editingController.clear();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  var totalTodos =
                      ctrl.todosInProgress.length + ctrl.todosOnFinished.length;
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16.0.wp, top: 2.0.wp, right: 16.0.wp),
                    child: Row(
                      children: [
                        Text(
                          '$totalTodos Tasks',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: ctrl.todosOnFinished.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [color.withOpacity(0.5), color],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.grey[300]!, Colors.grey[300]!],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.0.wp,
                ),
                child: TextFormField(
                  cursorHeight: 4.0.wp,
                  controller: ctrl.editingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (ctrl.formKey.currentState!.validate()) {
                          var success =
                              ctrl.addTodo(ctrl.editingController.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo item add success');
                          } else {
                            EasyLoading.showError('Todo item already exist');
                          }
                          ctrl.editingController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              InProgressList(),
              OnDoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
