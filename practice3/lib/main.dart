import 'package:flutter/material.dart';
import './animalItem.dart';
import 'first_page.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String Title_App='My App';
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MaterialMain(title: 'Flutter Demo Home Page',),
    );
  }
}

class MaterialMain extends StatefulWidget {
  final String title;
  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  List<Animal> animalList = new List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstPage(list: animalList,),
          SecondPage(list:animalList),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
        ],
        controller: _tabController,
      ),
    );
  }
  @override
  void initState(){
    _tabController = TabController(length: 2, vsync: this);
    animalList.add(Animal(animalName: '벌', kind: '곤충', imagePath: 'asset/images/bee.png'));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "asset/images/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "asset/images/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "asset/images/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "asset/images/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류", imagePath: "asset/images/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "asset/images/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "asset/images/wolf.png"));
  }
  @override
  void dispose(){
    _tabController!.dispose();
    super.dispose();
  }
}
