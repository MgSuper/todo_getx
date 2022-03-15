import 'package:getx_learn/data/models/task.dart';
import 'package:getx_learn/data/providers/task/task_provider.dart';

class TaskRepository {
  TaskProvider provider;
  TaskRepository({
    required this.provider,
  });

  List<Task> readTasks() => provider.readTasks();
  void writeTasks(List<Task> tasks) => provider.writeTasks(tasks);
}
