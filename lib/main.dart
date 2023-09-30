import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/blocs/task_bloc/task_bloc.dart';
import 'package:todo_app/page/task_screen.dart';
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
        providers: [BlocProvider(create: (BuildContext context) => TaskBloc())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App BloC',
          onGenerateRoute: appRoutes.onGenerateRoute,
          initialRoute: TaskScreen.id,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const TaskScreen(),
        ));
  }
}
