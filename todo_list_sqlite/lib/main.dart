import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/todo_create.dart';
import 'package:todo_list_sqlite/todo_finished.dart';
import 'package:todo_list_sqlite/util/todo_sqlite_database_provider.dart';
import 'material_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    TodoSQLiteDatabaseProvider databaseProvider = TodoSQLiteDatabaseProvider.getDatabaseProvider();

    return MaterialApp(
      title: _title,
    //  home: MaterialMain(),
      initialRoute: '/',
      routes: {
        '/': (context) => MaterialMain(databaseProvider: databaseProvider),
        '/create': (context) => TodoCreate(),
        '/finished': (context) => TodoFinished(),
      },
    );
  }
}

