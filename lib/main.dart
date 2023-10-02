import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo_app/blocs/switch_bloc/switch_state.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/page/tabs_screen.dart';
import 'package:todo_app/services/app_theme.dart';
import 'package:todo_app/services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());

  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => TaskBloc()),
          BlocProvider(create: (context) => SwitchBloc())
        ],
        child: BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App BloC',
            onGenerateRoute: appRoutes.onGenerateRoute,
            initialRoute: TabsScreen.id,
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
          );
        }));
  }
}
