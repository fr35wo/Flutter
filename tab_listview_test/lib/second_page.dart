import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _SecondApp(); //secondapp 반환하는 createstate함수
  final List<Animal>? list;

  SecondApp({Key? key, @required this.list}) : super(key: key);
}

enum AnimalSpecies { mammal, reptile, insect } //수업 라디오 내용

class _SecondApp extends State<SecondApp> {
  final nameController =
      TextEditingController(); //nameController 사용 위한 TextEditingController()함수의 반환값 받는 변수 final로 선언

  AnimalSpecies? _rqAnimalSpecies = AnimalSpecies.mammal; //수업 라디오 내용
  bool? _canfly = false; //checkbox value 변수
  String? _imagePath;

  int? _radioValue = 0; //라디오버튼 이용해 동물의 종류 선택할 수 있도록 //책내용
  bool? flyExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //widget담기
          TextField(
            //사용자가 통물 이름 입력할 텍스트필드
            controller: nameController,
            keyboardType: TextInputType.text,
            maxLines: 1,
          ),
          Row(//하나의 row에 listile 로 라디오 묶음
            mainAxisAlignment: MainAxisAlignment.center, //정렬
            children: <Widget>[
              Expanded(
                //row에 배치할 때 에러뜬다 주의 위젯 배치시 너비를 가변으로 바꿔 감싸 넣어야 함
                child: ListTile(  //radio
                  contentPadding: EdgeInsets.all(0), //패딩 주기
                  title: Text('포유류'),
                  leading: Radio<AnimalSpecies>(
                    value: AnimalSpecies.mammal,
                    groupValue: _rqAnimalSpecies,
                    onChanged: (AnimalSpecies? value) {
                      setState(() {
                        _rqAnimalSpecies = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(  //radio
                  contentPadding: EdgeInsets.all(0),
                  title: Text('파충류'),
                  leading: Radio<AnimalSpecies>(
                    value: AnimalSpecies.reptile,
                    groupValue: _rqAnimalSpecies,
                    onChanged: (AnimalSpecies? value) {
                      setState(() {
                        _rqAnimalSpecies = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                  child: ListTile(  //radio
                contentPadding: EdgeInsets.all(0),
                title: Text('곤충'),
                leading: Radio<AnimalSpecies>(
                  value: AnimalSpecies.insect,
                  groupValue: _rqAnimalSpecies,
                  onChanged: (AnimalSpecies? value) {
                    setState(() {
                      _rqAnimalSpecies = value;
                    });
                  },
                ),
              )),
            ],
          ),
          //체크박스는 listile과 row로 묶던 안묶던 상관 없다
          CheckboxListTile(
              title: Text('날 수 있나요?'),
              value: _canfly,
              onChanged: (bool? value) {
                setState(() {
                  _canfly = value;
                });
              }),
          Container( //gesture 마저넣기
            height: 100,
            child: ListView( //리스트 뷰 만들기 row로 만들면 화면 에러 때문에 container로 씀
              scrollDirection: Axis.horizontal, //height안주면 에러
              children: <Widget>[
                GestureDetector(  //터치 가능
                  child: Image.asset('asset/images/bee.png', width: 80),
                    onTap: () {
                      _imagePath = 'asset/images/bee.png';
                    },
                  ),
                GestureDetector(  //터치 가능
                  child: Image.asset('asset/images/cat.png', width: 80),
                  onTap: () {
                    _imagePath = 'asset/images/cat.png';
                  },
                ),
                GestureDetector(  //터치 가능
                  child: Image.asset('asset/images/cow.png', width: 80),
                  onTap: () {
                    _imagePath = 'asset/images/cow.png';
                  },
                ),
                GestureDetector(  //터치 가능
                  child: Image.asset('asset/images/dog.png', width: 80),
                  onTap: () {
                    _imagePath = 'asset/images/dog.png';
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('동물 추가'),
              onPressed: () {
                var animal = Animal(
                  animalName: nameController.value.text,
                  kind: getkind(_rqAnimalSpecies),
                  imagePath: _imagePath,
                  flyExist: _canfly
                );
                //p.141
              },
          ),
        ],
      ))),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  getkind(AnimalSpecies? animalSpecies) { //마저 넣기
    switch(animalSpecies) {
      case AnimalSpecies.reptile:
          return "양서류";
      case AnimalSpecies.mammal:
        return "포유류";
      case AnimalSpecies.insect:
        return "곤충";
    }
  }
}
