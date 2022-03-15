import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_learn/core/utils/keys.dart';
import 'package:getx_learn/data/models/task.dart';
import 'package:getx_learn/data/services/storage/storage_service.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // {'tasks': [
  //   {
  //     'title': 'Work',
  //     'color': '#ff123456',
  //     'icon': 0xe123,
  //   }
  // ]}

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((element) => tasks.add(Task.fromJson(element)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    // jsonEncode(tasks) will convert our tasks object to json
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
