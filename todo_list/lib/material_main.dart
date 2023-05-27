import 'package:flutter/material.dart';

//페이지가 넘어가면서 데이터를 어떻게 넘길까
//페이지 넘기기 1.push() 2.pushNamed() 1은 생성자로 2는 생성자 또는 argument로 넘긴다
//정적 -> 생성자 , 동적 -> argument
//스택 구조 이다.

class MaterialMain extends StatefulWidget {
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  List<String> todoList = List.empty(growable: true); //listview만들기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
          child: ListView.separated(
              itemCount: todoList.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                  color: Colors.blueGrey,
                );
              },
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    child: Text(todoList[index], style: TextStyle(fontSize: 20),),
                    onTap: () {                                 //인자로 전달하는 방식
                      Navigator.of(context).pushNamed('/detail', arguments: todoList[index]);

                    },
                  ),
                );
              }
              )
      ),
      floatingActionButton: FloatingActionButton( //누르면 todocreate호출
        child: Icon(Icons.add),
        onPressed: () {
          _createTodo();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    
    todoList.add("FLutter 공부");
    todoList.add("운동");
  }

  //비동기 = 시간 오래걸림   동적으로 생성된 데이터 받아와 todoList에 추가
  Future<void> _createTodo() async { //동적 데이터 argument로 넘기기     //String으로 던졌지만 받을땐 Object로 받는다 따라서 바꿔줌
    String todo = await Navigator.of(context).pushNamed("/create") as String; //navigator로 /create경로로 이동
    setState(() { //UI업데이트 위한 setState메서드
      todoList.add(todo);
    });
  }
}
