import 'package:flutter/material.dart';
import 'util/todo_sqlite_database_provider.dart';
import 'model/todo.dart';

class MaterialMain extends StatefulWidget {
  final TodoSQLiteDatabaseProvider databaseProvider;
  const MaterialMain({required this.databaseProvider});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  Future<List<Todo>>? todoList;


  @override
  void initState() {
    super.initState();
    todoList = _getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget'),
      ),
      body: Container(
        child:Center(
        child: FutureBuilder(
          future: todoList,
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError){
                return Text("Error: ${snapshot.error}");
              } else if(snapshot.hasData) {
                return ListView.separated(
                  itemCount: (snapshot.data as List<Todo>).length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: Colors.blueGrey,
                    );
                  },
                  itemBuilder: (context, index) {
                    Todo todo = (snapshot.data as List<Todo>)[index];
                    return ListTile(
                      title: Text(todo.title!, style: TextStyle(fontSize: 16),),
                      subtitle: Column(
                        children: <Widget>[
                          Text(todo.content!),
                          Text(todo.hasFinished == 1 ? "완료": "미완료"),
                        ],
                      ),
                      onTap: () {
                        _updateTodo(todo);
                      },
                      onLongPress: () {
                        _deleteTodo(todo);
                      },
                    );
                  },
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
          _createTodo();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _createTodo() async {
    Todo todo = await Navigator.of(context).pushNamed('/create') as Todo;
    await widget.databaseProvider.insertTodo(todo);
    setState(() {
      todoList = _getTodos();
    });
  }

  Future<List<Todo>> _getTodos() {
    return widget.databaseProvider.getTodos();
  }

  Future<void> _updateTodo(Todo todo) async {
    TextEditingController tecContentController = TextEditingController(text: todo.content,);
    bool isChecked = (todo.hasFinished == 1)? true: false;
    var resTodo = await showDialog(
        context: context,
        builder: (context) {
         return AlertDialog(
           title: Text("${todo.id}: ${todo.title}"),
           content: StatefulBuilder(
             builder: (context,setDialogState) {
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
                         setDialogState( () {
                           isChecked = value!;
                         });
                       },
                     ),
                   ],
                 ),
               );
             },
           ),
           actions: <Widget>[
             ElevatedButton(
               child: Text("수정"),
               onPressed: () {
                 todo.content = tecContentController.value.text;
                 todo.hasFinished = isChecked? 1: 0;
                 Navigator.of(context).pop(todo);
               },
             )
           ],
         ) ;
        }
        );
    if(resTodo != null) {
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
            content: Text("삭제?"),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("삭제"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
              ),
              ElevatedButton(
                  child: Text("취소"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
              )
            ],
          );
        });
    if(result as bool) {
      await widget.databaseProvider.deleteTodo(todo);
      setState(() {
        todoList = _getTodos();
      });
    }
  }

}
