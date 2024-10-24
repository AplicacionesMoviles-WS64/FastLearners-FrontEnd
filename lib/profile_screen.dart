import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String userName;
  final String email;

  const UserProfileScreen({
    Key? key,
    required this.userName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Acciones al editar el perfil
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Función de editar perfil no implementada')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
              child: Text(
                'Editar Perfil',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cerrando sesión...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}