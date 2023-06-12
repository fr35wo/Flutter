import 'package:flutter/material.dart';

class TodoFinished extends StatefulWidget {

  @override
  State<TodoFinished> createState() => _TodoFinished();
}

class _TodoFinished extends State<TodoFinished> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(

          ),
        ),
      ),
    );
  }
}