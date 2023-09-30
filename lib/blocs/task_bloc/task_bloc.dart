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
  }
  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        allTasks: List.from(state.allTasks)..add(event.task),
        removedTasks: List.from(state.removedTasks)));
  }

  void _updateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final int index = state.allTasks.indexOf(event.task);
    List<Task> tempList = List.from(state.allTasks)..remove(event.task);
    List<Task> tempList1 = List.from(state.removedTasks);
    event.task.isDone == false
        ? tempList.insert(index, event.task.copyWith(isDone: true))
        : tempList.insert(index, event.task.copyWith(isDone: false));
    emit(TaskState(allTasks: tempList, removedTasks: tempList1));
  }

  void _removeTaskEvent(RemoveTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
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
