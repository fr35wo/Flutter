import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'model/book.dart'; //외부 패키지 사용시 임포트
//많은 임포트 하다보면 같은 이름을 가진 클래스 함수가 있다 혼동 방지하기 위해 as http 는 이름을 주는 것
//kakao
//네이티브 앱 키	98743835306c707265dce7690f1d43e2
// REST API 키	3a0085897e5ff0a2c34c1d67adeba26f
// JavaScript 키	b848c938c82202fd32c0a759a0bca539
// Admin 키	263bfc7a286da0b4d181d5078e37d27a
//rest api를 통헤 json문자열을 받아옴 그걸 map data로 바꿈(디코딩)
//map을 다시 class 하나 만들어 매핑 => object 만들어짐
//책 modeling

class MaterialMain extends StatefulWidget {
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  static final String STR_URL = "http://www.google.com"; //1
  static final String API_SERVER = 'https://dapi.kakao.com/v3/search/book';
  static final String REST_API_KEY = '3a0085897e5ff0a2c34c1d67adeba26f';

  String strResult = " ";

  List<Book> bookList = List.empty(growable: true);

  //검색 기능
  TextEditingController _tecStrSearchQuery = TextEditingController();
  //스크롤의 현재 위치 파악
  ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _tecStrSearchQuery,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "검색",
            labelStyle: TextStyle(color: Colors.white),
            hintText: "검색어를 입력하세요",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.input),
          ),
        ),
      ),
      body: Container(
          child: bookList.isEmpty //booklist비었니 물어봄
              ? Text("No data")
              : ListView.separated(
                  itemCount: bookList.length,
                  controller: _scrollController, //리스트뷰에 붙이는 스크롤 컨트롤러
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: Colors.blueGrey,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: 80, minHeight: 80),
                        child: bookList[index].thumbnail == ""  //! = null이 아니다     thumbnail안나올때 아이콘 지정
                            ? Icon(Icons.book)
                            : Image.network(
                                bookList[index].thumbnail!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                      ),
                      title: Text(bookList[index].title!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //왼쪽정렬
                        children: <Widget>[
                          Text(bookList[index].authors.toString()),
                          Text(bookList[index].salePrice.toString()),
                          Text(bookList[index].status!),
                        ],
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        //1
        child: Icon(Icons.file_download),
        onPressed: () {
          //_httpDownloadUrl(STR_URL);
          _pageNumber = 1;
          bookList.clear();
          _getBookList();
        },
      ),
    );
  }

  @override
  void initState()  {
    super.initState();
    _scrollController.addListener(() {
      //scroll bottom check
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent
      && !_scrollController.position.outOfRange){
        print("Buttom");
        _pageNumber++;
        _getBookList();
      }
      if(_scrollController.offset <= _scrollController.position.minScrollExtent
          && !_scrollController.position.outOfRange){
        print("Top");
        if(_pageNumber > 1){
          _pageNumber--;
          _getBookList();
        }
      }
    });
  }


  void _getBookList() async {
    String strSearchTarget = 'target=title';
    String strSearchQuery = 'query=${_tecStrSearchQuery.value.text}';
    String strSearchPage = 'page=$_pageNumber';
    String strUrl = "$API_SERVER?$strSearchTarget&$strSearchQuery&$strSearchPage";

    var response = await http.get(
      Uri.parse(strUrl),
      headers: {"Authorization": "KakaoAK $REST_API_KEY"},
    );

    print(response.body);

    var jsonMapData = jsonDecode(response.body); //jsonmapdata들어옴
    var documentsMapList = jsonMapData['documents']
        as List; //doucument만 뽑아오기 / 리스트로 되어있어서 리스트로 받아옴
    bookList = documentsMapList
        .map((json) => Book.fromJson(json))
        .toList(); //리스트 있는 원소 하나씩 해당 함수에 넣기?
    print("bookList size: ${bookList.length}");
  }

  //async 시간 오래걸리니까 너는 별도로 수행해라 / 비동기로 수행
  void _httpDownloadUrl(String url) async {
    //1
    //이중에 밑에 애가 제일 시간 오래걸림 / await키워드 두고 이 전체함수 async로 뺀다
    var response = await http
        .get(Uri.parse(url)); //namespace 설정했으므로 http.과 같이 사용 get이용해 response받아옴
    setState(() {
      strResult = response.body;
    });
  }
}
