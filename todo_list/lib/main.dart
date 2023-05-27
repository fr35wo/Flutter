import 'package:flutter/material.dart';
import 'material_main.dart';
import 'todo_create.dart';
import 'todo_detail.dart';

void main() {
  runApp(MyApp());
}

//여기서 cupertino , material 정하기
class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      // home: MaterialMain(),

      //pushNamed()위한 라우터 지정
      initialRoute: '/',
      routes: {             //정적 데이터 생성자로 넘기기 가능
        '/': (context) => MaterialMain(),
        '/detail': (context) => TodoDetail(),
        '/create': (context) => TodoCreate(),
      },
    );
  }
}
