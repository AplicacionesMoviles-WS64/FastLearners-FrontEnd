import 'dart:ffi';

class foro{
  int? id;
  String title;
  String body;
  foro({
    this.id,
    required this.title,
    required this.body,
  });
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'body': body,
    };
  }
  static foro fromMap(Map<String, dynamic> map){
    return foro(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }


}