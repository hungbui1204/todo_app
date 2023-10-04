import 'package:equatable/equatable.dart';

import '../../model/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  const UpdateTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;
  const RemoveTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class RestoreTaskEvent extends TaskEvent {
  final Task task;
  const RestoreTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;
  const DeleteTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class SearchTaskEvent extends TaskEvent {
  final Task task;
  final String searchValue;
  const SearchTaskEvent({required this.task, required this.searchValue});
  @override
  List<Object?> get props => [task, searchValue];
}
