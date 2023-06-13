import 'package:flutter/material.dart';
import 'model/contact.dart';

class ContactCreate extends StatefulWidget {

  @override
  State<ContactCreate> createState() => _ContactCreate();
}

class _ContactCreate extends State<ContactCreate> {
  TextEditingController _tecNameController = TextEditingController();
  TextEditingController _tecAddressController = TextEditingController();
  TextEditingController _tecphoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactCreate in Final Exam'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
              child: TextField(
                controller: _tecNameController,
                decoration: InputDecoration(
                  labelText: "이름",
                ),
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _tecAddressController,
                  decoration: InputDecoration(
                    labelText: "주소",
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _tecphoneNumberController,
                  decoration: InputDecoration(
                    labelText: "전화번호",
                  ),
                ),
              ),
              ElevatedButton(
                  child: Text("생성"),
                  onPressed: () {
                    Contact contact = Contact(
                      name: _tecNameController.value.text,
                      address: _tecAddressController.value.text,
                      phoneNumber: _tecphoneNumberController.value.text
                    );
                    Navigator.of(context).pop(contact);
                  },
              ),
              ElevatedButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
