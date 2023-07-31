import 'package:flutter/material.dart';
import 'animalItem.dart';

class SecondPage extends StatefulWidget {
  final List<Animal>? list;

  const SecondPage({Key? key, @required this.list}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPage();
}

enum AnimalSpecies { mammal, leptile, insect }

class _SecondPage extends State<SecondPage> {
  final nameController = TextEditingController();
  AnimalSpecies? _rqAnimalSpecies = AnimalSpecies.mammal;
  bool? _canfly = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(0),
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
                  )),
                  Expanded(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('파충류'),
                    leading: Radio<AnimalSpecies>(
                      value: AnimalSpecies.leptile,
                      groupValue: _rqAnimalSpecies,
                      onChanged: (AnimalSpecies? value) {
                        setState(() {
                          _rqAnimalSpecies = value;
                        });
                      },
                    ),
                  )),
                  Expanded(
                      child: ListTile(
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
              CheckboxListTile(
                  title: Text('날 수 있나?'),
                  value: _canfly,
                  onChanged: (bool? value) {
                    setState(() {
                      _canfly = value;
                    });
                  }),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'asset/images/bee.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'asset/images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/cat.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/cow.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/dog.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/dog.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/fox.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/monkey.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/monkey.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/pig.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('asset/images/wolf.png', width: 80),
                      onTap: () {
                        _imagePath = 'asset/images/wolf.png';
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
                      flyExist: _canfly);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  getkind(AnimalSpecies? animalSpecies) {
    switch (animalSpecies) {
      case AnimalSpecies.mammal:
        return '포유류';
      case AnimalSpecies.leptile:
        return '파출류';
      case AnimalSpecies.insect:
        return '곤충';
    }
  }
}
