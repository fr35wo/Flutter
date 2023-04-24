import 'package:flutter/material.dart';

class Phone {
  String? imagePath; //이미지경로
  String? name; //이름
  String? number; //전화번호
  String? sex; //성별
  bool? exist = false;

  Phone(
      {required this.imagePath,
      required this.name,
      required this.number,
      required this.sex,
      this.exist});
}
