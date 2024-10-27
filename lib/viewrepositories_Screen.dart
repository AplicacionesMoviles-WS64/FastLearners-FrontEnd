import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:flutter/material.dart';
import 'createrepository_screen.dart';
import 'home_screen.dart';
import 'repository_screen.dart';

class RepositoryListScreen extends StatelessWidget {
  final List<Map<String, String>> repositories = [
    {
      'name': 'FastLearners',
      'description': 'Repositorio principal de FastLearners',
      'visibility': 'Público',
    },
    {
      'name': 'Project Alpha',
      'description': 'Repositorio del proyecto Alpha',
      'visibility': 'Privado',
    },
    {
      'name': 'Mobile App',
      'description': 'Repositorio para la aplicación móvil',
      'visibility': 'Público',
    },
    {
      'name': 'Data Analysis',
      'description': 'Repositorio de análisis de datos',
      'visibility': 'Privado',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Repositorios"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen(userName: '', email: '',)),
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
                  color: Color.fromRGBO(189, 213, 234, 1)
              ),
              child: Text(
                'Menú de navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Página de inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Crear repositorio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRepositoryScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Ver repositorios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepositoryListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          final repository = repositories[index];
          return Card(
            child: ListTile(
              title: Text(repository['name']!),
              subtitle: Text(repository['description']!),
              trailing: Text(repository['visibility']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepositoryScreen(
                      repositoryName: repository['name']!,
                      description: repository['description']!,
                      visibility: repository['visibility']!,
                      includeReadme: true,
                      includeGitignore: true,
                      collaborators: 'Sin colaboradores',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}