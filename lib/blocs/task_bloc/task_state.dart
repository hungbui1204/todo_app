import 'package:equatable/equatable.dart';

import '../../model/task_model.dart';

class TaskState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;
  const TaskState(
      {this.completedTasks = const <Task>[],
      this.removedTasks = const <Task>[],
      this.pendingTasks = const <Task>[],
      this.favoriteTasks = const <Task>[]});

  @override
  List<Object?> get props =>
      [pendingTasks, removedTasks, favoriteTasks, completedTasks];
  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((e) => e.toMap()).toList(),
      'completedTasks': completedTasks.map((e) => e.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((e) => e.toMap()).toList(),
      'removedTasks': removedTasks.map((e) => e.toMap()).toList()
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
        pendingTasks:
            List<Task>.from(map['pendingTasks']?.map((e) => Task.fromMap(e))),
        completedTasks:
            List<Task>.from(map['completedTasks']?.map((e) => Task.fromMap(e))),
        favoriteTasks:
            List<Task>.from(map['favoriteTasks']?.map((e) => Task.fromMap(e))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((e) => Task.fromMap(e))));
  }
}
