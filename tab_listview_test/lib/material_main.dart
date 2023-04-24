

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab_listview_test/first_page.dart';
import 'package:tab_listview_test/second_page.dart';
import'./animalItem.dart';


class MaterialMain extends StatefulWidget {
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain>
    with SingleTickerProviderStateMixin {
  //이걸 상속해야 해당 클래스에서 탭 컨트롤러 만들 수 있다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Example'),
      ),
      body: TabBarView(
        children: <Widget>[FirstPage(list: animalList), SecondApp(list: animalList)],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
      ], controller: controller,
      ),
    );
  }

  //탭 컨트롤러가 태바랑 탭바뷰 둘 다 쓰여서 변수로 만들어 initstate 오버라이딩 해서 쓴거다
  TabController? controller; //탭바 위젯 사용위한 탭 컨트롤러
  List<Animal> animalList = new List.empty(growable: true); //growable은 리스트가 가변적으로 증가할 수 있다 의미

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this); //탭바 위젯 사용위한 탭 컨트롤러

    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "asset/images/bee.png"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "asset/images/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "asset/images/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "asset/images/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "asset/images/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류", imagePath: "asset/images/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "asset/images/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "asset/images/wolf.png"));

  }

  @override //메모리 누수 막는 dispose()함수
  void dispose(){
    controller!.dispose();
    super.dispose();
  }
}