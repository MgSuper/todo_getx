import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/controllers/controllers.dart';
import 'package:getx_learn/widgets/build_status.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Report extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var allTasks = ctrl.getTotalTasks();
          var finishedTasks = ctrl.getTotalFinishedTask();
          var inProgressTasks = allTasks - finishedTasks;
          var percent = (finishedTasks / allTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
                child: const Divider(
                  thickness: 2.0,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildStatus(
                      inProgressTasks,
                      'active'.tr,
                      const Icon(
                        Icons.add_task,
                        color: Colors.green,
                      ),
                    ),
                    BuildStatus(
                      finishedTasks,
                      'finished'.tr,
                      const Icon(
                        Icons.task_alt,
                        color: Colors.red,
                      ),
                    ),
                    BuildStatus(
                      allTasks,
                      'all_tasks'.tr,
                      const Icon(
                        Icons.assignment_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: allTasks == 0 ? 1 : allTasks,
                    currentStep: finishedTasks,
                    stepSize: 16.0,
                    selectedColor: Colors.green.withOpacity(0.9),
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150.0,
                    height: 150.0,
                    selectedStepSize: 18.0,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${allTasks == 0 ? 0 : percent} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                        ),
                        SizedBox(
                          height: 1.0.wp,
                        ),
                        Text(
                          'efficiency'.tr,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
