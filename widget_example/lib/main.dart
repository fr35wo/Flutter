import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget { //statefulwidget 상속받는 클래스
  @override
  _WidgetExampleState createState() => _WidgetExampleState(); //createState통해서 state클래스 연결
}

class _WidgetExampleState extends State<WidgetApp> { //state 클래스 상속받는 클래스 / 스테이트풀 위젯을 화면에 출력하려면 state클래스 이용
  List _buttonList = ['더하기', '빼기', '곱하기', '나누기']; //리스트 선언후 아이템 입력
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable: true);//드롭다운 형식 리스트 하나 더 선언
  String? _buttonText;

  String sum = '';
  TextEditingController value1 = TextEditingController(); //텍스트 필드 이용하기 위한 컨트롤러 선언
  TextEditingController value2 = TextEditingController();

  @override //상태를 초기화하는 initState() 함수 재정의  /
  void initState() { //_buttonList에 있는 문자열 하나씩 빼서 _dropDownItemMenu 에 추가함으로써 아이템 목록을 펼침 버튼에 넣을 메뉴 아이템으로 만듬
    super.initState();
    for(var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column( //위젯 여러개 세로
            children: <Widget>[
              Padding( //위젯 사이 간격 벌림
                padding: EdgeInsets.all(15), //사방으로 15 여백
                child: Text(
                  '결과 : $sum', //결과 표시
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20), //원하는 부분 여백
                child: TextField(keyboardType: TextInputType.number, controller: value1), //텍스트 필드에 컨트롤러 선언,
                                                                                  // keyboardtype은 사용자에게 보일 키보드 지정
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value2),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                    child: Row( //위젯 여러개 가로
                      children: <Widget>[
                        Icon(Icons.add),
                        Text(_buttonText!) //사용자가 아이템 선택시 버튼 값도 수정
                      ],
                    ),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                    onPressed: () { //'버튼 눌리면' 발생하는 이벤트
                      setState(() { //위젯 상태 갱신 역할
                        var value1Int = double.parse(value1.value.text); //텍스트 필드에 있는 값 가져옴
                        var value2Int = double.parse(value2.value.text);
                        var result; //연산 코드
                        if(_buttonText == '더하기') {
                          result = value1Int + value2Int;
                        } else if (_buttonText == '빼기') {
                          result = value1Int - value2Int;
                        } else if (_buttonText == '곱하기') {
                          result = value1Int * value2Int; 
                        } else {
                          result = value1Int / value2Int;
                        }
                        sum = '$result';
                      });
                    }
                    ),
                ),
              Padding(padding: EdgeInsets.all(15),
                child: DropdownButton(items: _dropDownMenuItems, onChanged: (String? value){ //펼침 버튼 DropdownButton 
                                                      // item: 버튼에 표시할 아이템 목록/ onChanged: 아이템 바뀔때 처리할 이벤트
                  setState(() {
                    _buttonText = value;          //메뉴에 펼침 버튼 넣기
                  });
                },value: _buttonText,), 
              ),
            ],
            ),
          ),
        ),
      );
  }
}
