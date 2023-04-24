import 'package:flutter/material.dart';
import 'package:material_design_test/asset_test.dart';

//ctrl alt l 정렬
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //두번째 화면
      //home: const AssetTest(title: 'Material Design Test Asset Test'),
      //처음 화면
          home: const MaterialMain(title: 'Material Design Test Main'),
    );
  }
}

class MaterialMain extends StatefulWidget { //statefulwidget 상속받는 클래스
  const MaterialMain({super.key, required this.title});

  final String title;

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> { //state 클래스 상속받는 클래스 / 스테이트풀 위젯을 화면에 출력하려면 state클래스 이용
  @override
  Widget build(BuildContext context) {

    return Scaffold( //머티리얼 디자인 설계
      appBar: AppBar( //제목 줄 구현
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton( //떠 있는 듯한 버튼 구현 선언 후 함수 생성
        child: Icon(Icons.add), //버튼 안에 +모양 아이콘 표시
        onPressed: () {},
      ),
      body: Container( //메인 화면 구성 본문 Container: 위젯 담아 관리하는 상자
          child: Center( //가로 가운데 정렬
        child: Column(  //세로 위젯 배치
          mainAxisAlignment: MainAxisAlignment.center, //세로 가운데 정렬
          children: <Widget>[ //Column후 위젯 목록을 배열 형태로 나열할 기본 골격
            Icon(Icons.android),
            Text("Android"),
            ],
          ),
        )
      ),
    );
  }
}
