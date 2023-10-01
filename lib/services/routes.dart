import 'package:flutter/material.dart';
import 'package:todo_app/page/recycle_screen.dart';
import 'package:todo_app/page/task_screen.dart';

class AppRoutes {
  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TaskScreen.id:
        return MaterialPageRoute(builder: (_) => const TaskScreen());
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      default:
        return null;
    }
  }
}
