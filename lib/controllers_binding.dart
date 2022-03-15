import 'package:get/get.dart';
import 'package:getx_learn/data/providers/task/task_provider.dart';
import 'package:getx_learn/data/services/storage/task_repository.dart';
import 'package:getx_learn/controllers/home_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          provider: TaskProvider(),
        ),
      ),
    );
  }
}
