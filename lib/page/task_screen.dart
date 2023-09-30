import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';
import 'package:todo_app/page/recycle.dart';

import '../model/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);
  static const id = 'task_screen';

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
                                task: Task(
                                    title: titleController.text,
                                    id: DateTime.now().toString())));
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
      List<Task> allTasks = state.allTasks.reversed.toList();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'My Tasks',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Text(
                      'Task drawer',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('My tasks (${state.allTasks.length})'),
                  trailing: Icon(Icons.folder_shared),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Recycle bin (${state.removedTasks.length})'),
                  trailing: Icon(Icons.recycling),
                  onTap: () {
                    Navigator.of(context).pushNamed(RecycleBinScreen.id);
                  },
                )
              ],
            ),
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
                    state.allTasks.length > 1
                        ? '${state.allTasks.length} Tasks'
                        : '${state.allTasks.length} Task',
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
