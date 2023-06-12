class Todo{
  //멤버변수
  int? id;
  String? title;
  String? content;
  int? hasFinished; //1 true 0 false

  //생성자
  Todo({this.id, this.title, this.content, this.hasFinished});

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    hasFinished = map['hasFinished'];
  }

  Map<String, dynamic> toMap() { //todo객체 map으로 전환
    return{
      'id': id,
      'title': title,
      'content': content,
      'hasFinished': hasFinished,
    };
  }
}