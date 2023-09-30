import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../model/task_model.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);
  static const id = 'recycle_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> removedTasks = state.removedTasks.reversed.toList();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Recycle Bin',
            style: TextStyle(color: Colors.white),
          ),
        ),
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
                    state.removedTasks.length > 1
                        ? '${state.removedTasks.length} Tasks'
                        : '${state.removedTasks.length} Task',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.9,
                child: ListView.builder(
                    itemCount: removedTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          removedTasks[index].title,
                          style: TextStyle(
                              decoration: removedTasks[index].isDone!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: SizedBox(
                          width: width * 0.2,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: removedTasks[index].isDone,
                                  onChanged: (newValue) {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        UpdateTaskEvent(
                                            task: removedTasks[index]));
                                  }),
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        DeleteTaskEvent(
                                            task: removedTasks[index]));
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
