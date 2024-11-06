class Usuario {
  int? id;
  String nombre;
  String correo;
  String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.password,
  });

  // Convertir el objeto Usuario a un Map para guardar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'password': password,
    };
  }

  // Crear un objeto Usuario a partir de un Map proveniente de la base de datos
  Usuario.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        nombre = res["nombre"],
        correo = res["correo"],
        password = res["password"];
}