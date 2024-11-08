import 'dart:convert';
import 'dart:ffi';
import 'package:fastlearners_frontend_flutter/modelo/repository.dart';
import 'package:fastlearners_frontend_flutter/modelo/user.dart';
import 'package:http/http.dart' as http;

class ApiRestService {

  // Enlace del backend
  final String baseUrl = 'http://localhost:8080/api/v1';

  Future<void> insertUser(User user) async {
    final url = Uri.parse('$baseUrl/authentication/sign-up');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {
              "username": user.name,
              'email': user.email,
              'password': user.password,
              'memberships' : ["BASIC"]}),
      );

      if (response.statusCode == 201) {
        print("Usuario creado exitosamente");
      } else {
        print("Error al crear usuario: ${response.statusCode}");
      }
    } catch (exception) {
      print("Error al realizar la solicitud: $exception");
    }
  }

  Future<User?> getUserByCredentials(String username, String password) async {
    final url = Uri.parse('$baseUrl/authentication/sign-in');
    try {

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {
              'username': username,
              'password': password}),
      );

      if (response.statusCode == 200) {
        return User.fromMap(jsonDecode(response.body));

      } else {
        print("Credenciales incorrectas o usuario no encontrado");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
    return null;
  }

  Future<void> insertRepository(Repositorio repo) async {

    var url = Uri.parse('$baseUrl/repositories');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(repo.toMap()),
      );

      if (response.statusCode == 200) {
        print("Repositorio creado exitosamente");
      } else {
        print("Error al crear repositorio: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  Future<List<Repositorio>> getRepositories() async {

    var url = Uri.parse('$baseUrl/repositories');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {

        final List<dynamic> data = jsonDecode(response.body);
        print(response.body);

        return data.map((map) => Repositorio.fromMap(map)  ).toList();

      } else {
        print("Error al obtener repositorios: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
    return [];
  }

  Future<Repositorio?> getRepositoryById(int id) async {
    final url = Uri.parse('$baseUrl/repositories/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        return Repositorio.fromMap(data);

      } else {
        print("Repositorio no encontrado: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
    return null;
  }
}