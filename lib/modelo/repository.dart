class Repositorio {
  int? id;
  String name;
  String description;
  String visibility;
  bool includeReadme;
  bool includeGitignore;
  String collaborators;

  Repositorio({
    this.id,
    required this.name,
    required this.description,
    required this.visibility,
    required this.includeReadme,
    required this.includeGitignore,
    required this.collaborators,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'visibility': visibility,
      'includeReadme': includeReadme ? 1 : 0,
      'includeGitignore': includeGitignore ? 1 : 0,
      'collaborators': collaborators,
    };
  }

  static Repositorio fromMap(Map<String, dynamic> map) {
    return Repositorio(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      visibility: map["visibility"],
      includeReadme: map["includeReadme"] == 1,
      includeGitignore: map["includeGitignore"] == 1,
      collaborators: map["collaborators"],
    );

  }
}