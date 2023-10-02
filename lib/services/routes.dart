import 'package:flutter/material.dart';
import 'package:todo_app/page/recycle_screen.dart';

import '../page/tabs_screen.dart';

class AppRoutes {
  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      default:
        return null;
    }
  }
}
