import 'package:flutter/material.dart';

class TodoCreate extends StatefulWidget {
  @override
  State<TodoCreate> createState() => _TodoCreate();
}

class _TodoCreate extends State<TodoCreate> {
  TextEditingController _tecStrTodo = TextEditingController(); //textfield값 제어하기 위함
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo create'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _tecStrTodo,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '할일'
                ),
              ),
              ElevatedButton(
                child: Text('확인'),
                  onPressed:() { // navigator를 통해 현재 페이지를 닫고 이전 페이지로 돌아감
                    Navigator.of(context).pop(_tecStrTodo.value.text); //create에서 Main으로 값 넘기기 _createtodo로 감
                  },
                  )
            ],
          ),
        ),
      ),
    );
  }
}
