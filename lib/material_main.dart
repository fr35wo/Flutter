import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialMain extends StatefulWidget {
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  int counter = 0;
  IntegerStorage intStorage = IntegerStorage("counter.dat");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times: ',
                ),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _incrementCounter,
      ),
    );
  }

  //저장 방법 1 sharedpreference

  //initState 함수에서 데이터 로드
  // @override
  // void initState ()  { //initState는 원래 플러터 함수라 맘대로 async달면 에러 / 내가 만든 함수는 괜찮다
  //   // await만 단 상태에서 해결 방법 2가지
  //   super.initState();
  //    _loadIntFromSharedPreferences("counter").then((value) { //then은 그 값 채워질때까지 await해줌
  //     setState(() {
  //       counter = value;
  //     });
  //    }); //키만 받아오기
  //   // _loadIntFromSharedPreferences얘 때문에 얘도 시간 걸리는 함수가 되어버림
  // }

  // 버튼 클릭 시 상태 업데이트 및 SharedPreferences에 저장
  // void _incrementCounter() {
  //   setState(() {
  //     counter++;
  //   });
  //   _saveIntToSharedPreferences("counter", counter); //여기서 SharedPreferences에 저장
  // }

  // SharedPreferences에 int 데이터 저장
  // Future<void> _saveIntToSharedPreferences(String key, int value) async {
  //   SharedPreferences sharedPref = await SharedPreferences.getInstance(); //인스턴스 갖고와서
  //   sharedPref.setInt(key, value); //저장
  // }

  // SharedPreferences에서 int 데이터 로드 (방법 2가지)

  // //방법1-1 리턴 하지 않고 전역변수 counter를 여기서 설정 / 리턴하지 않으므로 위에 initstate async 달 필요 없음
  // // Future<void> _loadIntFromSharedPreferences(String key) async {
  // //   SharedPreferences sharedPref = await SharedPreferences.getInstance();
  // //   setState(() {
  // //     counter = sharedPref.getInt(key) ?? 0;
  // //   });
  // // }

  // //방법1-2 시간이 걸리지만 initstate에 async 안붙히고 해결 => then
  // Future<int> _loadIntFromSharedPreferences(String key) async {
  //   SharedPreferences sharedPref = await SharedPreferences.getInstance();
  //   return sharedPref.getInt(key) ?? 0; //받아오기 키가 있을수도 없을수도 있다. => ?? / ?기준 왼쪽 리턴 없으면 오른쪽 초기값리턴
  // }

  //저장 방법 2 파일에 읽고쓰기
  // initState 함수에서 데이터 로드
  @override
  void initState() {
    super.initState(); //최초엔 밑의 파일 없다
  //  _readIntFromFile("counter.dat").then((value) { //파일에서 데이터 읽을거다 2
 //    setState(() {
   //    counter = value;
   //  });
  //  });
    intStorage.read().then((value) {
      setState(() {
        counter = value;
      });
    });
  }
  // 버튼 클릭 시 상태 업데이트 및 파일에 저장
  void _incrementCounter() {
    setState(() {
      counter++;
    });
    //_writeIntToFile("counter.dat", counter); 2
    intStorage.write(counter);
  }
  // 파일에 int 데이터 쓰기
  Future<void> _writeIntToFile(String filename, int value) async {
    Directory appDocDir = await getApplicationDocumentsDirectory(); //디렉토리에서 가져오기
    var filePath = "${appDocDir.path}/$filename"; //전체 경로
    File file = File(filePath);//파일 객체

    file.writeAsString(value.toString()); //숫자인 데이터를 String으로 저장 => toString
  }
  // 파일에서 int 데이터 읽기
  Future<int> _readIntFromFile(String filename) async {
    Directory appDocDir = await getApplicationDocumentsDirectory(); //디렉토리에서 가져오기
    var filePath = "${appDocDir.path}/$filename"; //전체 경로

    try {
      File file = File(filePath); //파일 객체
      var value = await file.readAsString(); //read는 오래걸린다..
      return int.parse(value); //String 을 int로 =>int.parse()
    } catch(e) {
      return 0;
    }
  }
}

//방법 3
class IntegerStorage {
  String filename;
  IntegerStorage(this.filename);

  // 파일 객체 반환
  Future<File> _getFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory(); //디렉토리에서 가져오기
    var filePath = "${appDocDir.path}/$filename"; //전체 경로
    return File(filePath);//파일 객체
  }
  // 파일에 int 데이터 쓰기
  Future<File> write(int value) async {
    var file = await _getFile();
    return file.writeAsString(value.toString()); //숫자인 데이터를 String으로 저장 => toString
  }
  // 파일에서 int 데이터 읽기
  Future<int> read() async {
    try{
      var file = await _getFile();
      var value = await file.readAsString();
      return int.parse(value);
    } catch(e) {
      return 0;
    }
  }
  // initState 함수에서 IntegerStorage 클래스를 사용하여 데이터 로드
  // @override
  // void initState() {
  //   super.initState();
  //   intStorage.read().then((value) {
  //     setState(() {
  //       counter = value;
  //     });
  //   });
  // }
// 버튼 클릭 시 상태 업데이트 및 IntegerStorage 클래스를 사용하여 데이터 저장
//   void _incrementCounter() {
//     setState(() {
//       counter++;
//     });
//     intStorage.write(counter);
//   }

}