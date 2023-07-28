class Todo{
  int?id;
  String? title;
  String? content;
  int? hasFinished;

  Todo({this.id,this.title,this.content,this.hasFinished});

  Todo.fromMap(Map<String,dynamic>map){
    id=map['id'];
    title=map['title'];
    content=map['content'];
    hasFinished=map['hasFinished'];
  }

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'hasFinished': hasFinished
    };
  }

}