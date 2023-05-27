import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  @override
  State<TodoDetail> createState() => _TodoDetail();
}

class _TodoDetail extends State<TodoDetail> {
  @override
  Widget build(BuildContext context) {
    //여기에 데이터 들어옴
    String todo = ModalRoute.of(context)?.settings.arguments as String; //얘를 통해서 밑에 todo에게 전달

    return Scaffold(
      appBar: AppBar(
        title: Text('todo detail'),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Text(todo, style: TextStyle(fontSize: 20),), //전달 받은 todo값 표시
            ElevatedButton(
              child: Text('submit'),
              onPressed: () {
                Navigator.of(context).pop(); //화면 제거
              },
            ),
          ],
        )),
      ),
    );
  }
}
