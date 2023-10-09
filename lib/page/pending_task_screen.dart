import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';
import 'package:todo_app/widgets/task_appbar.dart';
import 'package:todo_app/widgets/task_card.dart';
import 'package:todo_app/widgets/task_info.dart';
import 'package:todo_app/widgets/task_tile.dart';

import '../model/task_model.dart';
import '../widgets/drawer.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({Key? key}) : super(key: key);

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> allTasks = state.pendingTasks.reversed.toList();
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
        appBar: taskAppBar('Pending Tasks'),
        drawer: buildDrawer(context, state),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  taskCard(context),
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
