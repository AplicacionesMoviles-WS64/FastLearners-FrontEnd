import 'dart:ffi';

import 'package:fastlearners_frontend_flutter/modelo/content.dart';
import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:fastlearners_frontend_flutter/viewrepositories_Screen.dart';
import 'package:flutter/material.dart';
import 'community_forum.dart';
import 'createrepository_screen.dart';
import 'database/api_rest_service.dart';
import 'home_screen.dart';
import 'uploadcontent_screen.dart';


class RepositoryScreen extends StatefulWidget {

  _ViewRepositoryScreenState createState() => _ViewRepositoryScreenState();

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

}

class _ViewRepositoryScreenState extends State<RepositoryScreen> {

  final ApiRestService _apiService = ApiRestService();
  List<Content> contents = [];

  Future<void> _fetchContents() async {
    var fetchedRepositories = await _apiService.getAllContentsByRepositoryId(widget.repositoryId);

    setState(() {
      contents = fetchedRepositories;
    });
  }

  @override
  void initState() {
    _fetchContents();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final List<String> collaboratorList = widget.collaborators.split(';').map((e) => e.trim()).toList();

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
                    backgroundImage: AssetImage('assets/images/avatar.png'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre del Repositorio
              Text(
                widget.repositoryName,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Descripción
              _buildInfoCard(
                title: 'Descripción',
                content: widget.description.isNotEmpty
                    ? widget.description
                    : 'Sin descripción',
              ),

              // Visibilidad
              _buildInfoCard(
                title: 'Visibilidad',
                content: widget.visibility,
              ),

              // Archivos incluidos
              _buildInfoCard(
                title: 'Archivos incluidos',
                content:
                'README.md: ${widget.includeReadme ? "Sí" : "No"}\n.gitignore: ${widget.includeGitignore ? "Sí" : "No"}',
              ),

              // Colaboradores
              SizedBox(height: 16),
              Text(
                'Colaboradores',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              collaboratorList.isNotEmpty && widget.collaborators.isNotEmpty
                  ? Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: collaboratorList
                    .map((collaborator) => Chip(
                  label: Text(collaborator),
                  backgroundColor: Colors.blue.shade100,
                ))
                    .toList(),
              )
                  : Text('Sin colaboradores', style: TextStyle(fontSize: 16)),

              // Botón de subir contenido
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadContentScreen(
                          repositoryName: widget.repositoryName,
                          repositoryId: widget.repositoryId,
                        ),
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

              // Lista de Contenidos
              SizedBox(height: 20),
              Text(
                'Contenidos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(189, 213, 234, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    var contentItem = contents[index];
                    return _buildContentCard(contentItem);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildInfoCard({required String title, required String content}) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
Widget _buildContentCard(Content contentItem) {
  return Card(
    margin: EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Título: ${contentItem.titleContent}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("Tipo: ${contentItem.contentType}", style: TextStyle(fontSize: 14)),
          Text("Descripción: ${contentItem.description}",
              style: TextStyle(fontSize: 14)),
          Text("Visibilidad: ${contentItem.visibility}",
              style: TextStyle(fontSize: 14)),
          Text("Colaboradores: ${contentItem.collaborators}",
              style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}