import 'package:finalexam202301_seokhyeon_201914068/material_main.dart';
import 'package:flutter/material.dart';
import 'contact_create.dart';
import 'contact_detail.dart';
import 'util/contact_sqlite_database_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Final Exam App 2023-01';

  @override
  Widget build(BuildContext context) {
    ContactSQLiteDatabaseProvider databaseProvider = ContactSQLiteDatabaseProvider.getDatabaseProvider();
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => MaterialMain(databaseProvider: databaseProvider),
        '/create': (context) => ContactCreate(),
        '/detail': (context) => ContactDetail(),
      },
    );


  }
}


