import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_learn/data/models/task.dart';

import 'package:getx_learn/data/services/storage/task_repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({
    required this.taskRepository,
  });
  final formKey = GlobalKey<FormState>();
  final editingController = TextEditingController();
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final todosInProgress = <dynamic>[].obs;
  final todosOnFinished = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }

  void changeTabIndex(int value) {
    tabIndex.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    todosInProgress.clear();
    todosOnFinished.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        todosOnFinished.add(todo);
      } else {
        todosInProgress.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containsTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containsTodo(List todos, String title) {
    return todos.any((e) => e['title'] == title);
  }

  bool addTodo(String title) {
    var todoInProgress = {'title': title, 'done': false};
    if (todosInProgress
        .any((e) => mapEquals<String, dynamic>(todoInProgress, e))) {
      return false;
    }
    var todoOnDone = {'title': title, 'done': true};
    if (todosOnFinished.any((e) => mapEquals(todoOnDone, e))) {
      return false;
    }
    todosInProgress.add(todoInProgress);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...todosInProgress,
      ...todosOnFinished,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var todoInProgress = {'title': title, 'done': false};
    int index = todosInProgress
        .indexWhere((e) => mapEquals<String, dynamic>(todoInProgress, e));
    todosInProgress.removeAt(index);
    var todoOnFinished = {'title': title, 'done': true};
    todosOnFinished.add(todoOnFinished);
    todosInProgress.refresh();
    todosOnFinished.refresh();
  }

  void deleteFinishedTask(dynamic finishedTask) {
    int index = todosOnFinished
        .indexWhere((e) => mapEquals<String, dynamic>(finishedTask, e));
    todosOnFinished.removeAt(index);
    todosOnFinished.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getFinishedTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTasks() {
    var res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalFinishedTask() {
    var res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (var j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
