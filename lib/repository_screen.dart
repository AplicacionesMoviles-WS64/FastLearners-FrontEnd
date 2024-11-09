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
                widget.repositoryName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(widget.description.isNotEmpty ? widget.description : 'Sin descripción'),
              SizedBox(height: 16),
              Text(
                'Visibilidad:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.visibility,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Incluir README.md: ${widget.includeReadme ? "Sí" : "No"}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Incluir .gitignore: ${widget.includeGitignore ? "Sí" : "No"}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Colaboradores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              collaboratorList.isNotEmpty && widget.collaborators.isNotEmpty
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
                        builder: (context) => UploadContentScreen(repositoryName: widget.repositoryName, repositoryId: widget.repositoryId,),
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
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(189, 213, 234, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SizedBox(
                  height: 200,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: GridView.builder(
                      primary: true, // Usar el PrimaryScrollController por defecto
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 4 / 3,
                      ),
                      itemCount: contents.length,
                      itemBuilder: (context, index) {

                        var contentItem = contents[index];

                        var titleContent = contentItem.titleContent;
                        var contentType = contentItem.contentType;
                        var description = contentItem.description;
                        var visibility = contentItem.visibility;
                        var collaborators = contentItem.collaborators;

                        return Container(

                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Title: $titleContent", style: const TextStyle(fontSize: 16)),
                                Text("Type: $contentType", style: const TextStyle(fontSize: 16)),
                                Text("Description: $description", style: const TextStyle(fontSize: 16)),
                                Text("Visibility: $visibility", style: const TextStyle(fontSize: 16)),
                                Text("Collaborators: $collaborators", style: const TextStyle(fontSize: 16)),

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}