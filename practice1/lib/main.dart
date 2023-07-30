import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice1/material_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String Title_App = 'My App';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if(Platform.isIOS ){
    //   return CupertinoApp(
    //     theme: CupertinoThemeData(
    //       primaryColor: CupertinoColors.systemBlue,
    //     ),
    //     home: CupertinoMain(title: "$Title_App for IOS",),
    //   );
    // } else  {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MaterialMain(title: "$Title_App for Android",),
      );
    }
}
