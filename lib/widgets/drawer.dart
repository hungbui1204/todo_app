import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo_app/blocs/switch_bloc/switch_event.dart';
import 'package:todo_app/blocs/switch_bloc/switch_state.dart';
import 'package:todo_app/blocs/task_bloc/task_state.dart';
import 'package:todo_app/page/tabs_screen.dart';

import '../page/recycle_screen.dart';

Drawer buildDrawer(BuildContext context, TaskState taskState) {
  return Drawer(
    child: SafeArea(
      child: ListView(
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Text(
                'Task drawer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
                'My tasks (${taskState.pendingTasks.length + taskState.completedTasks.length})'),
            trailing: const Icon(Icons.folder_shared),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.id);
            },
          ),
          ListTile(
            title: Text('Recycle bin (${taskState.removedTasks.length})'),
            trailing: const Icon(Icons.recycling),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RecycleBinScreen.id);
            },
          ),
          BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
            return Switch(
                value: state.switchValue,
                onChanged: (newValue) {
                  newValue
                      ? BlocProvider.of<SwitchBloc>(context)
                          .add(SwitchOnEvent(value: state.switchValue))
                      : BlocProvider.of<SwitchBloc>(context)
                          .add(SwitchOffEvent(value: state.switchValue));
                });
          })
        ],
      ),
    ),
  );
}
