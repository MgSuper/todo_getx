import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_learn/constants/style.dart';
import 'package:getx_learn/controllers/controllers.dart';
import 'package:getx_learn/core/values/colors.dart';
import 'package:getx_learn/data/models/task.dart';
import 'package:getx_learn/core/utils/extensions.dart';
import 'package:getx_learn/screens/home/widgets/add_card.dart';
import 'package:getx_learn/screens/home/widgets/add_dialog.dart';
import 'package:getx_learn/screens/home/widgets/task_card.dart';
import 'package:getx_learn/screens/report/report.dart';
import 'package:getx_learn/widgets/language_menu.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _locale = Get.find<LocaleController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Obx(
          () => Text(
            controller.tabIndex.value == 0 ? 'list'.tr : 'report'.tr,
            style:
                _locale.getLocale() == 'MM' ? mTitleTextStyle : eTitleTextStyle,
          ),
        ),
        actions: [
          LanguageMenu(),
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  // shrinkWrap: true because we add GridView in ListView
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          size: 6.0.wp,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.5.wp,
                          ),
                          child: Text(
                            'remove_card'.tr,
                            style: _locale.getLocale() == 'MM'
                                ? mNormalTextStyle
                                : eNormalTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        AddCard(),
                        ...controller.tasks
                            .map(
                              (e) => LongPressDraggable(
                                data: e,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.5,
                                  child: TaskCard(task: e),
                                ),
                                child: TaskCard(task: e),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Report(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton.extended(
              extendedIconLabelSpacing: 0.0.wp,
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blueAccent,
              onPressed: () {
                controller.editingController.clear();
                if (controller.tasks.isNotEmpty) {
                  Get.to(
                    () => AddDialog(),
                    transition: Transition.downToUp,
                  );
                } else {
                  EasyLoading.showInfo('Please create your task first');
                }
              },
              label: Text(
                controller.deleting.value ? 'delete'.tr : 'add'.tr,
                style: _locale.getLocale() == 'MM'
                    ? mFloatingTextStyle
                    : eFloatingTextStyle,
              ),
              icon: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) {
              controller.changeTabIndex(index);
            },
            currentIndex: controller.tabIndex.value,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
