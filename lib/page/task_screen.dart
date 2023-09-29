import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';

import '../model/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController titleController = TextEditingController();
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(),
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 20,
                    left: 20,
                    right: 20),
                child: Column(
                  children: [
                    const Text('Add Task'),
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          label: Text('Title'), border: OutlineInputBorder()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              titleController.clear();
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                                task: Task(title: titleController.text)));
                            Navigator.pop(context);
                            titleController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<Task> allTasks = state.allTasks;
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.9,
                child: ListView.builder(
                    itemCount: allTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(allTasks[index].title),
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
                                        DeleteTaskEvent(task: allTasks[index]));
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.add)),
      );
    });
  }
}
