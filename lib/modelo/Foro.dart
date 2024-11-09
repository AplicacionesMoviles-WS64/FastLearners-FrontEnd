class Foro{
  int? id;
  String title;
  String body;
  Foro({
    this.id,
    required this.title,
    required this.body,
});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}