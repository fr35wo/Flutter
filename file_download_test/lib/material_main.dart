import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//외부 패키지
//dio는 HTTP 요청을 처리하고 파일을 다운로드하기 위해 사용
//path_provider는 앱의 파일 시스템 경로를 얻기 위해 사용됩니다.

//StatefulWidget을 상속하는 위젯 클래스.
// 앱의 메인 화면을 구성하고, 다운로드 버튼과 다운로드된 이미지를 표시하는 기능을 제공.
class MaterialMain extends StatefulWidget {
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

//MaterialMain의 State 클래스로, 위젯의 상태를 관리. 다운로드된 파일의 상태를 나타내는
// _imageFile 변수를 관리하고, 다운로드 진행률을 표시하는 _strDownloadProgress 변수를 업데이트.
class _MaterialMain extends State<MaterialMain> {
  static final String DOWNLOAD_URL = "https://images.pexels.com/photos/240040";
  static final String DOWNLOAD_OPTION_STR = "auto=compress";

  String downloadFilename = "pexels-photo-240040.jpeg";
  String _strDownloadProgress = " "; //현재 얼마나 다운받았나

  Future<File>? _imageFile; //imageFile정의

  ////앱의 화면을 구성하는 위젯 트리를 반환.
  // FutureBuilder 위젯을 사용하여 _imageFile 변수에 따라 화면을 다르게 표시.
  // 다운로드 진행 중일 때는 원형 진행 표시기와 진행률 텍스트를 표시하고,
  // 다운로드가 완료되면 다운로드된 이미지를 표시.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _imageFile,
          builder: (context, snapshot) {
            //가라로 리턴 snapshot있다치고 하고 코딩
            if (snapshot.connectionState == ConnectionState.waiting) {
              //connectionstate.waiting
              return Container(
                width: 200,
                height: 120,
                child: Card(
                  color: Colors.black,
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _strDownloadProgress,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("error: ${snapshot.hasError}");
              } else if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Image.file(snapshot.data!) // ! = null이아니다
                  ],
                );
              } else {
                return Text("Empty data");
              }
            } else {
              //connectionstate가 none인 경우
              return Text("ConnectionState: ${snapshot.connectionState}");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download), //누르면 다운로드
        onPressed: () {
          _imageFile =
              _downloadFile(downloadFilename); //리턴 해놓고 futurebuilder에서 처리
        },
      ),
    );
  }

  //주어진 URL에서 파일을 다운로드하고, 다운로드 진행률을 업데이트하는 비동기 함수.
  // Dio 라이브러리를 사용하여 파일을 다운로드하며, 다운로드 중에는 진행률을 업데이트하기 위해
  // setState를 호출. 다운로드가 완료되면 다운로드된 파일을 반환.
  Future<File> _downloadFile(String filename) async {
    Directory appDocdir =
        await getApplicationDocumentsDirectory(); //path provider 임포트해서 사용가능
    // 시간 오래걸림 A value of type 'Future<Directory>' can't be assigned to a variable of type 'Directory'.
    // (Documentation)  Try changing the type of the variable, or casting the right-hand type to 'Directory'.
    //시간 오래걸리는 작업 별도로 빼라 전에 배운 async await
    //1234 가다가 3번을 뺐는데 4번에서 3번의 결과가 필요할때 있다. 1.await달기
    // 2.future = 먼저리턴(껍데기만 주고 3번 끝나면 알맹이 채워줌)
    //future builder = future가지구 화면에 뿌려주는 뭐 그런거..

    var filePathSaved = "${appDocdir.path}/$filename"; //실제 저장 위치

    String url = "$DOWNLOAD_URL/$filename?$DOWNLOAD_OPTION_STR";

    await Dio().download(url, filePathSaved, //이건 리턴 해줘야해서 await
        onReceiveProgress: (count, total) {
      //다운로드중 패킷 받을때마다 한번씩 호출되는 함수
      print("$filePathSaved: Received: $count bytes, Total: $total bytes.");
      setState(() {
        //패킷 다운받을때마다 setstate호출
        _strDownloadProgress =
            "Downloading $filename: ${((count / total) * 100).toStringAsFixed(0)} %";
      });
    });
    //
    return File(filePathSaved);
  }
}
