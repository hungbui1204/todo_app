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
    on<SearchTaskEvent>(_searchTaskEvent);
  }
  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks),
        removedTasks: List.from(state.removedTasks)));
  }

  void _updateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    if (event.task.isDeleted == false) {
      if (event.task.isDone == false) {
        state.pendingTasks.remove(event.task);
        List<Task> tempCompletedList = List.from(state.completedTasks);
        tempCompletedList.add(event.task.copyWith(isDone: true));
        emit(TaskState(
            pendingTasks: List.from(state.pendingTasks),
            completedTasks: List.from(tempCompletedList),
            favoriteTasks: List.from(state.favoriteTasks),
            removedTasks: List.from(state.removedTasks)));
      } else {
        state.completedTasks.remove(event.task);
        List<Task> tempPendingList = List.from(state.pendingTasks);
        tempPendingList.add(event.task.copyWith(isDone: false));
        emit(TaskState(
            pendingTasks: List.from(tempPendingList),
            completedTasks: List.from(state.completedTasks),
            favoriteTasks: List.from(state.favoriteTasks),
            removedTasks: List.from(state.removedTasks)));
      }
      // final int index1 = state.pendingTasks.indexOf(event.task);
      // final int index2 = state.completedTasks.indexOf(event.task);
    } else {
      final int index = state.removedTasks.indexOf(event.task);
      List<Task> tempList = List.from(state.removedTasks)..remove(event.task);
      event.task.isDone == false
          ? tempList.insert(index, event.task.copyWith(isDone: true))
          : tempList.insert(index, event.task.copyWith(isDone: false));
      emit(TaskState(
          pendingTasks: List.from(state.pendingTasks),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(tempList)));
    }
  }

  void _removeTaskEvent(RemoveTaskEvent event, Emitter<TaskState> emit) {
    if (event.task.isDone == true) {
      emit(TaskState(
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          pendingTasks: List.from(state.pendingTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    } else {
      emit(TaskState(
          pendingTasks: List.from(state.pendingTasks)..remove(event.task),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    }
  }

  void _restoreTaskEvent(RestoreTaskEvent event, Emitter<TaskState> emit) {
    if (event.task.isDone == true) {
      emit(TaskState(
          completedTasks: List.from(state.completedTasks)
            ..add(event.task.copyWith(isDeleted: false)),
          pendingTasks: List.from(state.pendingTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)..remove(event.task)));
    } else {
      emit(TaskState(
          pendingTasks: List.from(state.pendingTasks)
            ..add(event.task.copyWith(isDeleted: false)),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)..remove(event.task)));
    }
  }

  void _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks),
      completedTasks: List.from(state.completedTasks),
      favoriteTasks: List.from(state.favoriteTasks),
    ));
  }

  void _searchTaskEvent(SearchTaskEvent event, Emitter<TaskState> emit) {
    List<Task> searchedTasks = [];
    if (event.task.isDone == false) {
      if (event.searchValue != '') {
        List<Task> listTask = state.pendingTasks;
        for (Task task in listTask) {
          if (task.title
              .toLowerCase()
              .contains(event.searchValue.toLowerCase())) {
            searchedTasks.add(task);
          }
        }
        print(searchedTasks.length);
      } else {
        List<Task> listTask = state.pendingTasks;
        List<Task> searchedTasks = [];
        for (Task task in listTask) {
          searchedTasks.add(task);
        }
      }
    } else {
      List<Task> listTask = state.completedTasks;
      for (Task task in listTask) {
        if (task.title
            .toLowerCase()
            .contains(event.searchValue.toLowerCase())) {
          searchedTasks.add(task);
        }
      }
    }
    emit(TaskState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks),
        searchedTasks: searchedTasks));
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
