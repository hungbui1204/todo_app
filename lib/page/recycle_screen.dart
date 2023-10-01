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
                        contentPadding: const EdgeInsets.only(left: 15),
                        title: Text(
                          removedTasks[index].title,
                          style: TextStyle(
                              decoration: removedTasks[index].isDone!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: SizedBox(
                          width: width * 0.25,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: removedTasks[index].isDone,
                                  onChanged: (newValue) {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        UpdateTaskEvent(
                                            task: removedTasks[index]));
                                  }),
                              SizedBox(
                                  width: width * 0.1,
                                  child: PopupMenuButton(
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                                onTap: () {
                                                  BlocProvider.of<TaskBloc>(
                                                          context)
                                                      .add(RestoreTaskEvent(
                                                          task: removedTasks[
                                                              index]));
                                                },
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Restore'),
                                                    Icon(
                                                      Icons.restore,
                                                      color: Colors.blue,
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                onTap: () {
                                                  BlocProvider.of<TaskBloc>(
                                                          context)
                                                      .add(DeleteTaskEvent(
                                                          task: removedTasks[
                                                              index]));
                                                },
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Delete permanently'),
                                                    Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    )
                                                  ],
                                                )),
                                          ]))
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
