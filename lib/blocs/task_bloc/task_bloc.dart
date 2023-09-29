import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';

import '../../model/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const InitTaskState()) {
    on<AddTaskEvent>(_addTask);
    on(_updateTaskEvent);
    on(_deleteTaskEvent);
  }
  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  void _updateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final int index = state.allTasks.indexOf(event.task);
    List<Task> tempList = List.from(state.allTasks)..remove(event.task);
    event.task.isDone == false
        ? tempList.insert(index, event.task.copyWith(isDone: true))
        : tempList.insert(index, event.task.copyWith(isDone: false));
    emit(TaskState(allTasks: tempList));
  }

  void _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(allTasks: List.from(state.allTasks)..remove(event.task)));
  }
}
