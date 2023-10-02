import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../model/task_model.dart';
import '../widgets/drawer.dart';

class FavoriteTask extends StatelessWidget {
  const FavoriteTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> allTasks = state.favoriteTasks.reversed.toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorite Tasks',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: buildDrawer(context, state),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.9,
                child: ListView.builder(
                    itemCount: allTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          allTasks[index].title,
                          style: TextStyle(
                              decoration: allTasks[index].isDone!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: SizedBox(
                          width: width * 0.2,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: allTasks[index].isDone,
                                  onChanged: (newValue) {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        UpdateTaskEvent(task: allTasks[index]));
                                  }),
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        RemoveTaskEvent(task: allTasks[index]));
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
