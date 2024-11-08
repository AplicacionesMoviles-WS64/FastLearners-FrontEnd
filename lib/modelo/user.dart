class User {
  int? id;
  String name;
  String email;
  String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  // Convertir el objeto Usuario a un Map para guardar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Crear un objeto Usuario a partir de un Map proveniente de la base de datos
  User.fromMap(Map<String, dynamic> res):
        id = res["id"],
        name = res["username"],
        email = "",
        password = "";
}