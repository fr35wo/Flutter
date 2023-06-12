import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';

class TodoSQLiteDatabaseProvider {
  static const String DATABASE_FILENAME = "todo_database.db"; //런타임 떄 변경이면 final 안바뀌면 const
  static const String TODOS_TABLENAME = "todos";

  //싱글톤? 객체 하나만 만드는 방식?
  static TodoSQLiteDatabaseProvider databaseProvider = TodoSQLiteDatabaseProvider._(); //밖에서 이 객체 못만듬
  // => 생성자 private => 언더바로 시작하는 아무이름 줘버림 => 디폴트 생성자 안만듬

  static Database? database; //데베 작업 위함

  TodoSQLiteDatabaseProvider._();

  static TodoSQLiteDatabaseProvider getDatabaseProvider() => databaseProvider;
  //밖에서 getDatabaseProvider()하면 databaseProvider 호출 //밖에서 못만드니까 static

  Future<Database> _getDatabase() async {
    return database ??= await _initDatabase(); //평상시 return database null일때 오른쪽 return
  }

  //db객체와 CRUD encapsulation하는 거???
  Future<Database> _initDatabase() async {
    return openDatabase( //데베 열기
        join(await getDatabasesPath(), DATABASE_FILENAME),
        version: 1,
        onCreate: (db, version) { //최초생성
      return db.execute(
          'CREATE TABLE $TODOS_TABLENAME(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, hasFinished INTEGER)');
    });
  }
//Create
  Future<void> insertTodo(Todo todo) async {
    Database database = await _getDatabase();
    //db에 넣으려면 클래스를 맵으로                                 //중복되면 replace해라
    database.insert(TODOS_TABLENAME, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Read
  Future<List<Todo>> getTodos() async{
    Database database = await _getDatabase();
    var maps = await database.query(TODOS_TABLENAME); //조건안걸고 다 긁어오기

    List<Todo> todoList = List.empty(growable: true);
    for(Map<String, dynamic> map in maps) { //List에 있는애들 하나씩 긁어옴
      todoList.add(Todo.fromMap(map));
    }
    return todoList;
  }

  //Update
  Future<void> updateTodo(Todo todo) async {
    Database database = await _getDatabase();
    database.update(TODOS_TABLENAME, todo.toMap(), where: 'id = ?', whereArgs: [todo.id] );
  }

  //Delete
  Future<void> deleteTodo(Todo todo) async {
    Database database = await _getDatabase();
    database.delete(TODOS_TABLENAME, where: 'id = ?', whereArgs: [todo.id] );
  }

}
