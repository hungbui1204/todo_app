import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../model/task_model.dart';

ListTile taskTile(BuildContext context, Task task) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return ListTile(
    title: Text(
      task.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration:
              task.isDone! ? TextDecoration.lineThrough : TextDecoration.none),
    ),
    subtitle: Text('Created time: ${task.time}'),
    trailing: SizedBox(
      width: width * 0.2,
      child: Row(
        children: [
          Checkbox(
              value: task.isDone,
              onChanged: (newValue) {
                BlocProvider.of<TaskBloc>(context)
                    .add(UpdateTaskEvent(task: task));
              }),
          GestureDetector(
              onTap: () {
                BlocProvider.of<TaskBloc>(context)
                    .add(RemoveTaskEvent(task: task));
              },
              child: const Icon(Icons.delete)),
        ],
      ),
    ),
  );
}
