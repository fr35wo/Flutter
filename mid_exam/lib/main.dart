import 'package:flutter/material.dart';

import 'contact_create.dart';
import 'contact_list.dart';
import 'phone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MaterialMain(title: 'MidExam 2023-01'),
    );
  }
}

class MaterialMain extends StatefulWidget {
  final String title;

  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Phone> phoneList = new List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MidExam 2023-01'),
      ),
      body: TabBarView(
        children: <Widget>[
          ContactCreate(list: phoneList),
          ContactList(list: phoneList),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.create, color: Colors.blue),
          ),
          Tab(
            icon: Icon(Icons.list, color: Colors.blue),
          ),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    phoneList.add(Phone(
        name: '김철수',
        number: '010-1234-5678',
        sex: '남성',
        imagePath: 'asset/images/skhu_symbol.jpg'));
    phoneList.add(Phone(
        name: '이영희',
        number: '010-1234-5678',
        sex: '여성',
        imagePath: 'asset/images/skhu_symbol.jpg'));
    phoneList.add(Phone(
        name: '홍길동',
        number: '010-1234-5678',
        sex: '남성',
        imagePath: 'asset/images/skhu_symbol.jpg'));
    phoneList.add(Phone(
        name: '조준수',
        number: '010-1234-5678',
        sex: '남성',
        imagePath: 'asset/images/skhu_symbol.jpg'));
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
