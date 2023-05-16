import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './phone.dart';

class ContactList extends StatefulWidget {
  final List<Phone>? list;

  const ContactList({Key? key, @required this.list}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactList();
}

class _ContactList extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        widget.list![position].imagePath!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      Text(widget.list![position].name!),
                      Text(widget.list![position].number!),
                      Text(widget.list![position].sex!),
                    ],
                  ),
                ),
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이름: ${widget.list![position].name}                                                                       '
                      '전화번호: ${widget.list![position].number}                                                                  '
                      '성별: ${widget.list![position].sex}                                                                        ',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              );
            },
            itemCount: widget.list!.length,
          ),
        ),
      ),
    );
  }
}
