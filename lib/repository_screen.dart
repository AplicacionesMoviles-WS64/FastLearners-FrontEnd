import 'package:flutter/material.dart';
import 'uploadcontent_screen.dart';

class RepositoryScreen extends StatelessWidget {
  final String repositoryName;
  final String description;
  final String visibility;
  final bool includeReadme;
  final bool includeGitignore;
  final String collaborators;

  const RepositoryScreen({
    Key? key,
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
        title: Text('Repositorio: $repositoryName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre del Repositorio:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
                        builder: (context) => UploadContentScreen(),
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