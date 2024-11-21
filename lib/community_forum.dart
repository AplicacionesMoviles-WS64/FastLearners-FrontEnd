import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:fastlearners_frontend_flutter/viewrepositories_Screen.dart';
import 'package:flutter/material.dart';

import 'createForo_screen.dart';
import 'createrepository_screen.dart';
import 'home_screen.dart';

class CommunityForum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4, // Sombra debajo del AppBar
        backgroundColor: Color.fromRGBO(254, 95, 85, 1), // Color principal
        title: Text(
          'FastLearners', // Cambia por el título que prefieras
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Centra el título
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notificaciones no implementadas')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(userName: '', email: ''),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(189, 213, 234, 1), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/home/avatar.png'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'usuario@email.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Página de inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.create, color: Colors.green),
              title: Text('Crear repositorio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRepositoryScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.folder, color: Colors.orange),
              title: Text('Ver repositorios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RepositoryListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.forum, color: Colors.purple),
              title: Text('Foro de la comunidad'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityForum()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForumCreateScreen(userId: 1,),
                          ),
                        );
                      },
                      child: const Text('Nuevo post',),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(254, 95, 85, 1),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),

              // Cuadro de Nuevos Posts
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(189, 213, 234, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nuevos Posts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Títulos más grandes
                    const SizedBox(height: 10),

                    _buildPostRow('¿Cómo empezar con Flutter?',
                        'En este post discutimos los primeros pasos para desarrollar aplicaciones en Flutter.',
                        '5 mensajes'),
                    const SizedBox(height: 10),

                    _buildPostRow('Tips de programación en Python',
                        'Comparte tus mejores consejos y trucos para programar en Python.',
                        '8 mensajes'),
                    const SizedBox(height: 10),

                    _buildPostRow('Mejores prácticas en desarrollo web',
                        'Discutimos las mejores prácticas y frameworks para el desarrollo web.',
                        '2 mensajes'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Cuadro de Categorías
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(189, 213, 234, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Categorías', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Títulos más grandes
                    const SizedBox(height: 10),
                    _buildCategoryRow('Programación', 'Discusiones sobre lenguajes y técnicas de programación.'),
                    const SizedBox(height: 10),
                    _buildCategoryRow('Frameworks', 'Comparte y discute sobre diferentes frameworks de desarrollo.'),
                    const SizedBox(height: 10),
                    _buildCategoryRow('Aplicaciones Web', 'Todo sobre el desarrollo de aplicaciones web.'),
                    const SizedBox(height: 10),
                    _buildCategoryRow('Aplicaciones de Desktop', 'Discusiones sobre el desarrollo de software de escritorio.'),
                    const SizedBox(height: 10),
                    _buildCategoryRow('Sistemas Operativos', 'Intercambia conocimientos sobre sistemas operativos.'),
                    const SizedBox(height: 10),
                    _buildCategoryRow('Otros', 'Cualquier tema que no encaje en las categorías anteriores.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Cuadro de Usuarios en Línea
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(189, 213, 234, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Usuarios en línea', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Títulos más grandes
                    const SizedBox(height: 10),
                    _buildOnlineUserRow('Pedro123', 'Conectado a las 10:15 AM'),
                    const SizedBox(height: 5),
                    _buildOnlineUserRow('Ursula2', 'Conectado a las 10:20 AM'),
                    const SizedBox(height: 5),
                    _buildOnlineUserRow('Jose', 'Conectado a las 10:25 AM'),
                    const SizedBox(height: 5),
                    _buildOnlineUserRow('Marco', 'Conectado a las 10:30 AM'),
                    const SizedBox(height: 5),
                    _buildOnlineUserRow('Jonatan', 'Conectado a las 10:35 AM'),
                    const SizedBox(height: 5),
                    _buildOnlineUserRow('Mesias', 'Conectado a las 10:40 AM'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildPostRow(String title, String description, String messagesCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), // Título más grande
              Text(description),
            ],
          ),
        ),
        Text(messagesCount),
      ],
    );
  }


  Widget _buildCategoryRow(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(description),
      ],
    );
  }


  Widget _buildOnlineUserRow(String username, String connectionTime) {
    return Text('$username - $connectionTime');
  }
}
