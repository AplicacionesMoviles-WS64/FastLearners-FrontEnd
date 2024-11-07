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
      'nombre': name,
      'descripcion': description,
      'visibilidad': visibility,
      'incluirReadme': includeReadme ? 1 : 0,
      'incluirGitignore': includeGitignore ? 1 : 0,
      'colaboradores': collaborators,
    };
  }

  Repositorio.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["nombre"],
        description = map["descripcion"],
        visibility = map["visibilidad"],
        includeReadme = map["incluirReadme"] == 1,
        includeGitignore = map["incluirGitignore"] == 1,
        collaborators = map["colaboradores"];
}