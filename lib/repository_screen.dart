import 'dart:ffi';

import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:fastlearners_frontend_flutter/viewrepositories_Screen.dart';
import 'package:flutter/material.dart';
import 'community_forum.dart';
import 'createrepository_screen.dart';
import 'home_screen.dart';
import 'uploadcontent_screen.dart';

class RepositoryScreen extends StatelessWidget {

  final int repositoryId;
  final String repositoryName;
  final String description;
  final String visibility;
  final bool includeReadme;
  final bool includeGitignore;
  final String collaborators;

  const RepositoryScreen({
    Key? key,
    required this.repositoryId,
    required this.repositoryName,
    required this.description,
    required this.visibility,
    required this.includeReadme,
    required this.includeGitignore,
    required this.collaborators,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<String> collaboratorList = collaborators.split(';').map((e) => e.trim()).toList();

    return Scaffold(
      appBar: AppBar(
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
                color: Color.fromRGBO(189, 213, 234, 1),
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
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Foro de la comunidad'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityForum()),
                );
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repositoryName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(description.isNotEmpty ? description : 'Sin descripción'),
              SizedBox(height: 16),
              Text(
                'Visibilidad:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                visibility,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Incluir README.md: ${includeReadme ? "Sí" : "No"}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Incluir .gitignore: ${includeGitignore ? "Sí" : "No"}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Colaboradores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              collaboratorList.isNotEmpty && collaborators.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: collaboratorList
                    .map((collaborator) => Text(
                  collaborator,
                  style: TextStyle(fontSize: 16),
                ))
                    .toList(),
              )
                  : Text('Sin colaboradores'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadContentScreen(repositoryName: repositoryName, repositoryId: repositoryId,),
                      ),

                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  ),
                  child: Text(
                    'Subir contenido',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}