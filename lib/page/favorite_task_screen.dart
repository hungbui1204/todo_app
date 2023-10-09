import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../model/task_model.dart';
import '../widgets/drawer.dart';
import '../widgets/task_appbar.dart';
import '../widgets/task_info.dart';
import '../widgets/task_tile.dart';

class FavoriteTask extends StatelessWidget {
  const FavoriteTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> allTasks = state.favoriteTasks.reversed.toList();
      allTasks.sort(
        (a, b) => b.time.compareTo(a.time),
      );
      List<Task> searchedTasks = state.searchedTasks.reversed.toList();
      searchedTasks.sort((a, b) => b.time.compareTo(a.time));
      void handleSearch(String input) {
        BlocProvider.of<TaskBloc>(context)
            .add(SearchTaskEvent(searchValue: input, task: allTasks.first));
      }

      return Scaffold(
        appBar: taskAppBar('Favorite Tasks'),
        drawer: buildDrawer(context, state),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300),
                    child: Center(
                      child: Text(
                        state.favoriteTasks.length > 1
                            ? '${state.favoriteTasks.length} Tasks'
                            : '${state.favoriteTasks.length} Task',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: TextField(
                      onChanged: handleSearch,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search',
                          contentPadding: EdgeInsets.zero),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: (searchedTasks.isEmpty ? allTasks : searchedTasks)
                      .map((task) => ExpansionPanelRadio(
                          value: task.id,
                          headerBuilder: (context, isOpened) =>
                              taskTile(context, task),
                          body: taskInfo(task)))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
