import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/core/values/colors.dart';
import 'package:getx_learn/controllers/home_controller.dart';

class OnDoneList extends StatelessWidget {
  final ctrl = Get.find<HomeController>();
  OnDoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ctrl.todosOnFinished.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0.wp, vertical: 2.0.wp),
                  child: Text(
                    'Completed ( ${ctrl.todosOnFinished.length} )',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...ctrl.todosOnFinished
                    .map(
                      (e) => Dismissible(
                        key: ObjectKey(e),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ctrl.deleteFinishedTask(e);
                        },
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.0.wp),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0.wp, horizontal: 7.5.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.check_box,
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0.wp, right: 4.0.wp, top: 1.8.wp),
                                child: Text(
                                  e['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      decorationColor: Colors.red,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
