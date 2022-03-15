import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/controllers/controllers.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/core/values/colors.dart';
import 'package:getx_learn/controllers/home_controller.dart';

class InProgressList extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  InProgressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _locale = Get.find<LocaleController>();
    return Obx(
      () => ctrl.todosInProgress.isEmpty && ctrl.todosOnFinished.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/no_task.png',
                  fit: BoxFit.cover,
                  width: 36.0.wp,
                ),
                SizedBox(
                  height: _locale.getLocale() == 'MM' ? 0.0.wp : 1.0.wp,
                ),
                Text(
                  'notask'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 4.0.wp, right: 4.0.wp, top: 6.0.wp, bottom: 2.0.wp),
                  child: Text(
                    ctrl.todosInProgress.length == 1
                        ? 'Remaining Task ( ${ctrl.todosInProgress.length} )'
                        : 'Remaining Tasks ( ${ctrl.todosInProgress.length} )',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                ...ctrl.todosInProgress
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0.wp, horizontal: 7.5.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.green),
                                value: e['done'],
                                onChanged: (value) {
                                  ctrl.doneTodo(
                                    e['title'],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.0.wp, right: 4.0.wp, top: 0.5.wp),
                              child: Text(
                                e['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (ctrl.todosInProgress.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            ),
    );
  }
}
