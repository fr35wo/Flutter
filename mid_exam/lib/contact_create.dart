import 'package:flutter/material.dart';

import './phone.dart';

class ContactCreate extends StatefulWidget {
  final List<Phone>? list;

  const ContactCreate({Key? key, @required this.list}) : super(key: key);

  @override
  State<ContactCreate> createState() => _ContactCreate();
}

enum SexSpecies { male, female }

class _ContactCreate extends State<ContactCreate> {
  final nameController = TextEditingController(); //이름
  final numberController = TextEditingController(); //전번
  SexSpecies? _rqSexSpecies = SexSpecies.male;
  bool? _canfriend = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('연락처 생성', style: TextStyle(fontSize: 5.0),),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('남성'),
                  leading: Radio<SexSpecies>(
                    value: SexSpecies.male,
                    groupValue: _rqSexSpecies,
                    onChanged: (SexSpecies? value) {
                      setState(() {
                        _rqSexSpecies = value;
                      });
                    },
                  ),
                )),
                Expanded(
                    child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('여성'),
                  leading: Radio<SexSpecies>(
                    value: SexSpecies.female,
                    groupValue: _rqSexSpecies,
                    onChanged: (SexSpecies? value) {
                      setState(() {
                        _rqSexSpecies = value;
                      });
                    },
                  ),
                )),
              ],
            ),
            CheckboxListTile(
                title: Text('친구인가요?'),
                value: _canfriend,
                onChanged: (bool? value) {
                  setState(() {
                    _canfriend = value;
                  });
                }),
            ElevatedButton(
                child: Text('연락처 생성'),
                onPressed: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                  '이름: ${nameController.value.text}                                                                                  '
                  '전화번호: ${numberController.value.text}                                                                             '
                  '성별: ${getsex(_rqSexSpecies)}                                                                                     '
                      '친구 여부: ${_canfriend}',
                    style: TextStyle(fontSize: 15.0),
                    ),
                  );
                  showDialog(context: context,
                      builder: (BuildContext context) => dialog);
                  var phone = Phone(
                      name: nameController.value.text,
                      number: numberController.value.text,
                      sex: getsex(_rqSexSpecies),
                      imagePath: _imagePath,
                      exist: _canfriend);
                }),
          ],
        )),
      ),
    );
  }

  getsex(SexSpecies? sexSpecies) {
    switch (sexSpecies) {
      case SexSpecies.male:
        return '남성';
      case SexSpecies.female:
        return '여성';
    }
  }
}
