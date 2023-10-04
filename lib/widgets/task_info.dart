import 'package:flutter/material.dart';

import '../model/task_model.dart';

Widget taskInfo(Task task) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Text',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(task.title),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(task.description == '' ? '(none)' : task.description),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ),
  );
}
