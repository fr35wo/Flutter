import 'dart:convert'; //JSON데이터 이용하기 위한 convert패키지 추가
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http; //네트워크 통신을 위한 http패키지 추가

import 'model/book.dart'; //외부 패키지로 부터 받은 JSON데이터 매핑하기 위해 사용
//많은 임포트 하다보면 같은 이름을 가진 클래스 함수가 있다 혼동 방지하기 위해 as http 는 이름을 주는 것
//kakao
//네이티브 앱 키	98743835306c707265dce7690f1d43e2
// REST API 키	3a0085897e5ff0a2c34c1d67adeba26f
// JavaScript 키	b848c938c82202fd32c0a759a0bca539
// Admin 키	263bfc7a286da0b4d181d5078e37d27a
//rest api를 통헤 json문자열을 받아옴 그걸 map data로 바꿈(디코딩)
//map을 다시 class 하나 만들어 매핑 => object 만들어짐
//책 modeling

class MaterialMain extends StatefulWidget { //상태가 변경될 수 있는 위젯, 화면에 표시되는 위젯의 상태 관리
  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> { //build메서드 오버라이딩하여 위젯의 UI관리
  static final String STR_URL = "http://www.google.com"; //1
  static final String API_SERVER = 'https://dapi.kakao.com/v3/search/book';
  static final String REST_API_KEY = '3a0085897e5ff0a2c34c1d67adeba26f';

  String strResult = " "; //검색결과 저장하는 문자열 변수

  List<Book> bookList = List.empty(growable: true); //검색된 도서 목록 저장하는 리스트

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
              ? Text("No data") //검색결과 없을때
              : ListView.separated( //있을때 / ListView.Builder 형태에서 구분선이 필요할 때 사용.
                  itemCount: bookList.length,
                  controller: _scrollController, //리스트뷰에 붙이는 스크롤 컨트롤러
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: Colors.blueGrey,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile( //리스트뷰 각 항목에 대한 아이콘, 텍스트 등 나열
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
      floatingActionButton: FloatingActionButton( //검색 버튼 클릭시 _getBookList();호출되어 도서 목록 검색
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
  void initState()  { //_scrollController에 대한 이벤트 리스너 등록, 스크롤 위치에 따라 페이지 변경
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
//요청에는 Authorization 헤더에 REST API 키가 포함되어 전송
    var response = await http.get(
      Uri.parse(strUrl),
      headers: {"Authorization": "KakaoAK $REST_API_KEY"},
    );

    print(response.body);
//응답은 JSON 형식으로 받아오며, jsonDecode 함수를 사용하여 JSON 문자열을 Map 데이터로 디코딩
    var jsonMapData = jsonDecode(response.body); //jsonmapdata들어옴
    var documentsMapList = jsonMapData['documents']
        as List; //doucument만 뽑아오기 / 리스트로 되어있어서 리스트로 받아옴
    //documents 키에 해당하는 값을 리스트로 추출, 각 아이템을 Book.fromJson 메서드를 통해 Book 객체로 매핑
    bookList = documentsMapList
        .map((json) => Book.fromJson(json))
        .toList(); //이렇게 생성된 도서 객체들 bookList에 추가
    print("bookList size: ${bookList.length}");
  }

  //get방식으로 URL에 접속하는 코드
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
