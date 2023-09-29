import 'package:equatable/equatable.dart';

import '../../model/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent({required this.task});
  @override
  List<Object?> get props => [];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  const UpdateTaskEvent({required this.task});
  @override
  List<Object?> get props => [];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;
  const DeleteTaskEvent({required this.task});
  @override
  List<Object?> get props => [];
}
