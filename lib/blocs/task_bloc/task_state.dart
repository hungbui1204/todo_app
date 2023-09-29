import 'package:equatable/equatable.dart';

import '../../model/task_model.dart';

class TaskState extends Equatable {
  final List<Task> allTasks;
  const TaskState({required this.allTasks});

  @override
  List<Object?> get props => [allTasks];
}

class InitTaskState extends TaskState {
  const InitTaskState() : super(allTasks: const <Task>[]);
}
