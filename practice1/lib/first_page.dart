import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'animalItem.dart';

class FirstPage extends StatefulWidget {
  final String title;
  final List<Animal>? list;

  const FirstPage({Key? key, @required this.list, required this.title})
      : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      Text(widget.list![position].animalName!)
                    ],
                  ),
                ),
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    content: Text(
                      '이 동물은 ${widget.list![position].kind}',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
                }
              );
            },
            itemCount: widget.list!.length,
          ),
        ),
      ),
    );
  }
}
