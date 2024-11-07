import 'package:fastlearners_frontend_flutter/modelo/repositorio.dart';
import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:flutter/material.dart';
import 'community_forum.dart';
import 'createrepository_screen.dart';
import 'database/api_service.dart';
import 'home_screen.dart';
import 'repository_screen.dart';

class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryScreenState createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryListScreen> {

  final APIService _apiService = APIService();
  List<Repositorio> repositories = [];

  Future<void> _fetchRepositories() async {
    var fetchedRepositories = await _apiService.getRepositories();
    
    setState(() {
      repositories = fetchedRepositories;
    });
  }
  @override
  void initState() {
    _fetchRepositories();
    super.initState();
  }

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
      body: ListView.builder(
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          final repository = repositories[index];
          return Card(
            child: ListTile(
              title: Text(repository.name),
              subtitle: Text(repository.description),
              trailing: Text(repository.visibility),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepositoryScreen(
                      repositoryName: repository.name,
                      description: repository.description,
                      visibility: repository.visibility,
                      includeReadme: repository.includeReadme,
                      includeGitignore: repository.includeGitignore,
                      collaborators: repository.collaborators,
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