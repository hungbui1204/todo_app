import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';

import '../blocs/task_bloc/task_state.dart';

BlocBuilder taskCard(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return BlocBuilder<TaskBloc, TaskState>(
    builder: (BuildContext context, state) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 35,
        width: width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300),
        child: Center(
          child: Text(
            '${state.pendingTasks.length} Pending | ${state.completedTasks.length} Completed',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}
