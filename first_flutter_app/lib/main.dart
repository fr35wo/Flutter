import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }

  class _MyApp extends State<MyApp> {
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  var switchValue = false;
  return MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
  primarySwatch: Colors.blue,
  ),
  home: Scaffold(
    body: Center(
      child: Switch(
        value: switchValue,
        onChanged: (value){

            print(value);
            switchValue = value;
  );

  }
  )
  )
  )
  );
  }

  }
}





