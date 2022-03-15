import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/data/models/task.dart';
import 'package:getx_learn/screens/detail/detail.dart';
import 'package:getx_learn/controllers/home_controller.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        ctrl.changeTask(task);
        ctrl.changeTodos(task.todos ?? []);
        ctrl.editingController.clear();
        Get.to(() => Detail());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7.0,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              // TODO change after finished todo CRUD
              totalSteps: ctrl.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep:
                  ctrl.isTodosEmpty(task) ? 0 : ctrl.getFinishedTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  color.withOpacity(0.5),
                  color,
                ],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  task.todos == null
                      ? const Text(
                          '0 Task',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          task.todos?.length == 1
                              ? '${task.todos?.length} Task'
                              : '${task.todos?.length} Tasks',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
