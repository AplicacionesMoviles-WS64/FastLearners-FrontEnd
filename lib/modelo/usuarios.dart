class Usuario {
  final String nombre;
  final String correo;
  final String password;
  final String? plan;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.password,
    this.plan,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'correo': correo,
      'password': password,
      'plan': plan,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nombre: map['nombre'],
      correo: map['correo'],
      password: map['password'],
      plan: map['plan'],
    );
  }
}