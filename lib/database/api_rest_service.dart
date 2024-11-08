import 'dart:convert';
import 'dart:ffi';
import 'package:fastlearners_frontend_flutter/modelo/repository.dart';
import 'package:fastlearners_frontend_flutter/modelo/user.dart';
import 'package:http/http.dart' as http;

import '../modelo/payment_card.dart';

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

  void updateUserMembership(int id, String membership) async {
    final url = Uri.parse('$baseUrl/users/setMembership');

    try {

      var json = jsonEncode({
        'id': id,
        'memberships': [ membership ]
      });

      print(json);
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json ,
      );

      if (response.statusCode == 200) {
        print("Membresía actualizada exitosamente");
        return;
      } else {
        print("Error al actualizar membresía: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
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

  Future<void> insertPaymentCard(PaymentCard card) async {
    final url = Uri.parse('$baseUrl/paymentCards');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(card.toMap()),
      );

      if (response.statusCode == 201) {
        print("Tarjeta creada exitosamente");
      } else {
        print("Error al crear tarjeta: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }
  Future<void> createContent(String repositoryName, Map<String, dynamic> contentData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/repositories/$repositoryName/contents'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contentData),
    );

    if (response.statusCode == 201) {
      print('Content created successfully');
    } else {
      print('Failed to create content: ${response.statusCode}, ${response.body}');
    }
  }

}
