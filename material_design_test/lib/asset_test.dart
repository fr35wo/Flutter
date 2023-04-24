//두번째 화면 만들기 위해선 stf클래스 하나 더
import 'package:flutter/material.dart';

class AssetTest extends StatefulWidget{
  final String title;

  const AssetTest({super.key, required this.title}); //생성자

  @override //createState통해서 state클래스 연결
  State<AssetTest> createState() =>_AssetTest();
}

class _AssetTest extends State<AssetTest>{
  @override //state클래스에선 build메소드가 필요
  Widget build(BuildContext context) {
    // TODO: implement build
    //matirial design에서 Scaffold씀 cupertino import함
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/flutter.png', //이미지를 불러오는 코드
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              Text('Flutter',
                style: TextStyle(fontFamily: 'Pacifico',
                fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ),
      )
    );
  }
}