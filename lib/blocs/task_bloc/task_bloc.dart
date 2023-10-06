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
    on<EditTextEvent>(_editTaskEvent);
    on<FavoriteTaskEvent>(_favoriteTaskEvent);
  }
  void _addTask(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks),
        removedTasks: List.from(state.removedTasks)));
  }

  void _updateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    if (event.task.isFavorite == true) {
      final int index = state.favoriteTasks.indexOf(event.task);
      List<Task> favoriteList = List.from(state.favoriteTasks)
        ..remove(event.task);
      event.task.isDone!
          ? favoriteList.add(event.task.copyWith(isDone: false))
          : favoriteList.add(event.task.copyWith(isDone: true));
      emit(TaskState(
          favoriteTasks: favoriteList,
          pendingTasks: List.from(state.pendingTasks),
          completedTasks: List.from(state.completedTasks),
          removedTasks: List.from(state.removedTasks)));
    }
    if (event.task.isDeleted == false) {
      if (event.task.isDone == false && event.task.isFavorite == false) {
        state.pendingTasks.remove(event.task);
        List<Task> tempCompletedList = List.from(state.completedTasks);
        tempCompletedList.add(event.task.copyWith(isDone: true));
        emit(TaskState(
            pendingTasks: List.from(state.pendingTasks),
            completedTasks: List.from(tempCompletedList),
            favoriteTasks: List.from(state.favoriteTasks),
            removedTasks: List.from(state.removedTasks)));
      } else if (event.task.isDone == true && event.task.isFavorite == false) {
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
    if (event.task.isDone == true && event.task.isFavorite == true) {
      emit(TaskState(
          completedTasks: List.from(state.completedTasks),
          pendingTasks: List.from(state.pendingTasks),
          favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    } else if (event.task.isDone == false && event.task.isFavorite == true) {
      emit(TaskState(
          pendingTasks: List.from(state.pendingTasks),
          completedTasks: List.from(state.completedTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    }
    if (event.task.isDone == true && event.task.isFavorite == false) {
      emit(TaskState(
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          pendingTasks: List.from(state.pendingTasks),
          favoriteTasks: List.from(state.favoriteTasks),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    } else if (event.task.isDone == false && event.task.isFavorite == false) {
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

  void _editTaskEvent(EditTextEvent event, Emitter<TaskState> emit) {
    if (event.task.isDone == false) {
      final int index = state.pendingTasks.indexOf(event.task);
      state.pendingTasks.remove(event.task);
      List<Task> list = List.from(state.pendingTasks)
        ..insert(
            index,
            event.task.copyWith(
                title: event.editedTitle,
                description: event.editedDescription));
      emit(TaskState(
          pendingTasks: list,
          searchedTasks: List.from(state.searchedTasks),
          completedTasks: List.from(state.completedTasks),
          removedTasks: List.from(state.removedTasks),
          favoriteTasks: List.from(state.favoriteTasks)));
    } else {
      final int index = state.pendingTasks.indexOf(event.task);
      state.completedTasks.remove(event.task);
      List<Task> list = List.from(state.completedTasks)
        ..insert(
            index,
            event.task.copyWith(
                title: event.editedTitle,
                description: event.editedDescription));
      emit(TaskState(
          pendingTasks: List.from(state.pendingTasks),
          searchedTasks: list,
          completedTasks: List.from(state.completedTasks),
          removedTasks: List.from(state.removedTasks),
          favoriteTasks: List.from(state.favoriteTasks)));
    }
  }

  void _favoriteTaskEvent(FavoriteTaskEvent event, Emitter<TaskState> emit) {
    List<Task> favoriteList = List.from(state.favoriteTasks)
      ..add(event.task.copyWith(isFavorite: true));
    List<Task> pendingList = List.from(state.pendingTasks);
    List<Task> completedList = List.from(state.completedTasks);
    if (event.task.isDone == false) {
      pendingList.remove(event.task);
    } else {
      completedList.remove(event.task);
    }
    emit(TaskState(
        favoriteTasks: favoriteList,
        removedTasks: List.from(state.pendingTasks),
        completedTasks: completedList,
        pendingTasks: pendingList));
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
