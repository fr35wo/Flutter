import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/util/todo_sqlite_database_provider.dart';
import 'model/todo.dart';

class MaterialMain extends StatefulWidget {
  final TodoSQLiteDatabaseProvider databaseProvider;

  const MaterialMain({required this.databaseProvider});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
//CRUD구현

Future<List<Todo>>? todoList; //FutureBuilder때문에 Future

@override
  void initState() {
    super.initState();
    todoList = _getTodos(); //시간 오래걸림
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: todoList, //나중에 들어올 데이터
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); //기다리는중에 뺑뺑이 보여줌
              } else if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError) { //error있나 체크
                  return Text("Error: ${snapshot.error}");
                } else if(snapshot.hasData) {
                  return ListView.separated(
                    itemCount: (snapshot.data as List<Todo>).length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        color: Colors.blueGrey,
                      );
                    }, //구분선 만들어줌
                    itemBuilder: (context, index) {
                      Todo todo = (snapshot.data as List<Todo>)[index]; //index로 access
                      return ListTile(
                        title: Text(todo.title!, style: TextStyle(fontSize: 16),), //! => null이 아니다
                        subtitle: Column(
                          children: <Widget>[
                            Text(todo.content!),
                            Text(todo.hasFinished == 1? "완료": "미완료"),
                          ],
                        ),
                        onTap: () {
                          _updateTodo(todo);
                        },
                        onLongPress: () {
                          _deleteTodo(todo);
                        },
                      );
                    }
                  );
                } else {
                  return Text("Empty Data");
                }
              } else {
                return Text("ConnectionState: ${snapshot.connectionState}");
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _createTodo(); //todo생성
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _createTodo() async {
    //create에서 넘긴거 받기 Object로 받기 때문에 Todo로 다운 캐스팅해서 쓴다
    Todo todo = await Navigator.of(context).pushNamed('/create') as Todo; //create 로 pushNamed이용해 넘어감
    await widget.databaseProvider.insertTodo(todo); //provider 통해서 감    //insert하면서 setstate도 돌아간다 await달까말까
    setState(() { //create하고 화면 갱신                                     //달면 insert후 setstate
      todoList = _getTodos();
    });
  }

  Future<List<Todo>> _getTodos() { //db에 가서 읽어오기
    return widget.databaseProvider.getTodos(); //밖에서도 access하는 애라 _안붙임
  }

  //Update
  Future<void> _updateTodo(Todo todo) async {
  TextEditingController tecContentController = TextEditingController(
    text: todo.content,
  );
  bool isChecked = (todo.hasFinished == 1)? true: false;
    var resTodo = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${todo.id}: ${todo.title}"),
            content: StatefulBuilder( //바로바로 갱신
              builder: (context, setDialogState) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: tecContentController,
                        decoration: InputDecoration(
                          labelText: "할일",
                        ),
                      ),
                      CheckboxListTile(
                        title: Text("완료 여부"),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  )
                );
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text("수정"),
                onPressed: () {
                  todo.content = tecContentController.value.text;
                  todo.hasFinished = isChecked? 1:0;
                  Navigator.of(context).pop(todo); //showdialog의 리턴값이 된다
                },
              ),
              ElevatedButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop(todo); //showdialog의 리턴값이 된다
                },
              )
            ],
          );
        }
    );

    //Update null아닐때
    if(resTodo != null){
      await widget.databaseProvider.updateTodo(resTodo);
      setState(() {
        todoList = _getTodos();
      });
    }
  }

Future<void> _deleteTodo(Todo todo) async {
  var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${todo.id}: ${todo.title}"),
          content: Text("삭제하시겠습니까?"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("삭제"),
              onPressed: () {
                Navigator.of(context).pop(true); //showdialog의 리턴값이 된다
              },
            ),
            ElevatedButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.of(context).pop(false); //showdialog의 리턴값이 된다
              },
            )
          ],
        );
      }
  );

  if(result as bool) {
    await widget.databaseProvider.deleteTodo(todo);
    setState(() {
      todoList = _getTodos();
    });
  }

}

}