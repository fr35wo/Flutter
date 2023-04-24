import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../animalItem.dart'; //애니멀 클래스 사용위한 임포트

class CupertinoAnimalList extends StatefulWidget {

  final List<Animal>? list; //애니멀 리스트 선언
  CupertinoAnimalList({Key? key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      navigationBar: CupertinoNavigationBar(
        middle: Text('Tab Test'),

      ),
      child: Container(
          child: Center(
            child: ListView.builder(itemBuilder: (context, position){ //위젯 이용해 데이터 표시
              return GestureDetector( //터치 이벤트 처리 위젯
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: 90,
                  child: Column(
                    children: <Widget>[
                      Row( //가로 배열
                        children: <Widget>[ //위젯 배치
                          Image.asset(
                            list![position].imagePath!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          Text(list![position].animalName!)
                        ],
                      ),
                      Container(
                        height: 1,

                      )
                    ],
                  )

                ),
                onTap: (){ //터치 시 알림창 띄우는 이번트
                  CupertinoAlertDialog alertdialog = CupertinoAlertDialog(
                    content: Text(
                      '이 동물은 ${list![position].kind}입니다',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  );
                  showCupertinoDialog(context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) => alertdialog); //alterdialog 이용해 dialog라는 알림창 만들고 내용과 스타일을
                  //content와 style에 설정 showdialog() 호출해 알림 창 띄움
                },
              );
            }, //전체적인 리스트뷰의 사이즈 없으면 에러
              itemCount: list!.length,), //아이템 개수만큼만 스크롤 할 수 있게 제한
          )
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}