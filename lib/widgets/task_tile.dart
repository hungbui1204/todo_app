import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../model/task_model.dart';

ListTile taskTile(BuildContext context, Task task) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  TextEditingController titleController =
      TextEditingController(text: task.title);
  TextEditingController descriptionController =
      TextEditingController(text: task.description);
  return ListTile(
    leading: SizedBox(
        width: width * 0.1,
        child: GestureDetector(
            onTap: () {
              BlocProvider.of<TaskBloc>(context)
                  .add(FavoriteTaskEvent(task: task));
            },
            child: task.isFavorite!
                ? Icon(Icons.star, color: Colors.orangeAccent)
                : Icon(
                    Icons.star_border_purple500_outlined,
                    color: Colors.grey,
                  ))),
    title: Text(
      task.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration:
              task.isDone! ? TextDecoration.lineThrough : TextDecoration.none),
    ),
    subtitle: Text(
        'Created time: ${DateFormat('dd-MM-yyyy').add_jm().format(task.time)}'),
    trailing: SizedBox(
      width: width * 0.22,
      child: Row(
        children: [
          Checkbox(
              value: task.isDone,
              onChanged: (newValue) {
                BlocProvider.of<TaskBloc>(context)
                    .add(UpdateTaskEvent(task: task));
              }),
          SizedBox(
            width: width * 0.08,
            child: PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(),
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                            top: 20,
                                            left: 20,
                                            right: 20),
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Edit Task',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            TextField(
                                              controller: titleController,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                  label: Text('Title'),
                                                  border: OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              child: TextField(
                                                minLines: 3,
                                                maxLines: 5,
                                                controller:
                                                    descriptionController,
                                                decoration: const InputDecoration(
                                                    label: Text('description'),
                                                    border:
                                                        OutlineInputBorder()),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    BlocProvider.of<TaskBloc>(
                                                            context)
                                                        .add(EditTextEvent(
                                                            task: task,
                                                            editedTitle:
                                                                titleController
                                                                    .text,
                                                            editedDescription:
                                                                descriptionController
                                                                    .text));
                                                    Navigator.pop(context);
                                                  },
                                                  // style:
                                                  //     ElevatedButton.styleFrom(
                                                  //         backgroundColor:
                                                  //             Colors
                                                  //                 .deepPurple),
                                                  child: const Text(
                                                    'Edit',
                                                    // style: TextStyle(
                                                    //     color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edit'),
                              Icon(Icons.edit, color: Colors.green),
                            ],
                          )),
                      PopupMenuItem(
                          onTap: () {
                            BlocProvider.of<TaskBloc>(context)
                                .add(RemoveTaskEvent(task: task));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Move to recycle bin'),
                              Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ],
                          )),
                    ]),
          )
          // GestureDetector(
          //     onTap: () {
          //       BlocProvider.of<TaskBloc>(context)
          //           .add(RemoveTaskEvent(task: task));
          //     },
          //     child: const Icon(Icons.delete)),
        ],
      ),
    ),
  );
}
