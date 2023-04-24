import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab_listview_test/first_page.dart';
import 'package:tab_listview_test/second_page.dart';
import './animalItem.dart';
import 'ios/cupertino_main.dart';
import 'material_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //어떤 위젯 만들것인지 정의
    if (true) { //Platform.isIOS
      return CupertinoApp(
        //아이폰
        title: 'Cupertino Design Test',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
        ),
        home: CupertinoMain(),
      );
    } else {
      return MaterialApp(
        //그림 그리는 도화지 //안드로이드 웹 등
        home: MaterialMain(),
      );
    }
  }
}
