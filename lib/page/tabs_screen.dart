import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_event.dart';
import 'package:todo_app/page/completed_task_screen.dart';
import 'package:todo_app/page/favorite_task_screen.dart';
import 'package:todo_app/page/pending_task_screen.dart';

import '../model/task_model.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'task_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;
  List<Map<String, dynamic>> tabs = [
    {'page': const PendingTaskScreen()},
    {'page': const CompletedTask()},
    {'page': const FavoriteTask()}
  ];
  void _addTask(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          label: Text('Title'), border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextField(
                        minLines: 3,
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            label: Text('description'),
                            border: OutlineInputBorder()),
                      ),
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
                                    description: descriptionController.text,
                                    id: DateTime.now().toString(),
                                    time: DateTime.now())));
                            Navigator.pop(context);
                            titleController.clear();
                            descriptionController.clear();
                          },
                          // style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.deepPurple),
                          child: const Text(
                            'Add',
                            // style: TextStyle(color: Colors.white),
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
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: tabs[currentIndex]['page'],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _addTask(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.add))
          : null,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pending'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite')
          ]),
    );
  }
}
