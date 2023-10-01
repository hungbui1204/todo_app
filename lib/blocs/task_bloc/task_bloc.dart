import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';

import '../../model/task_model.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<RemoveTaskEvent>(_removeTaskEvent);
    on<RestoreTaskEvent>(_restoreTaskEvent);
  }
  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        allTasks: List.from(state.allTasks)..add(event.task),
        removedTasks: List.from(state.removedTasks)));
  }

  void _updateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    if (event.task.isDeleted == false) {
      final int index = state.allTasks.indexOf(event.task);

      List<Task> tempList = List.from(state.allTasks)..remove(event.task);

      event.task.isDone == false
          ? tempList.insert(index, event.task.copyWith(isDone: true))
          : tempList.insert(index, event.task.copyWith(isDone: false));

      emit(TaskState(
          allTasks: List.from(tempList),
          removedTasks: List.from(state.removedTasks)));
    } else {
      final int index = state.removedTasks.indexOf(event.task);
      List<Task> tempList = List.from(state.removedTasks)..remove(event.task);
      event.task.isDone == false
          ? tempList.insert(index, event.task.copyWith(isDone: true))
          : tempList.insert(index, event.task.copyWith(isDone: false));
      emit(TaskState(
          allTasks: List.from(state.allTasks),
          removedTasks: List.from(tempList)));
    }
  }

  void _removeTaskEvent(RemoveTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void _restoreTaskEvent(RestoreTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        allTasks: List.from(state.allTasks)
          ..add(event.task.copyWith(isDeleted: false)),
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        allTasks: List.from(state.allTasks)));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
