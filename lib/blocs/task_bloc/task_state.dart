import 'package:equatable/equatable.dart';

import '../../model/task_model.dart';

class TaskState extends Equatable {
  final List<Task> allTasks;
  final List<Task> removedTasks;
  const TaskState(
      {this.allTasks = const <Task>[], this.removedTasks = const <Task>[]});

  @override
  List<Object?> get props => [allTasks, removedTasks];
  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((e) => e.toMap()).toList(),
      'removedTasks': removedTasks.map((e) => e.toMap()).toList()
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
        allTasks: List<Task>.from(map['allTasks']?.map((e) => Task.fromMap(e))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((e) => Task.fromMap(e))));
  }
}
