class Content {
  int? id;
  String titleContent;
  String contentType;
  String description;
  String visibility;
  String collaborators;
  int repositoryId; 

  Content({
    this.id,
    required this.titleContent,
    required this.contentType,
    required this.description,
    required this.visibility,
    required this.collaborators,
    required this.repositoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleContent': titleContent,
      'contentType': contentType,
      'description': description,
      'visibility': visibility,
      'collaborators': collaborators,
      'repositoryId': repositoryId,
    };
  }


  static Content fromMap(Map<String, dynamic> map) {
    return Content(
      id: map['id'],
      titleContent: map['titleContent'],
      contentType: map['contentType'],
      description: map['description'],
      visibility: map['visibility'],
      collaborators: map['collaborators'],
      repositoryId: map['repositoryId'],
    );
  }
}