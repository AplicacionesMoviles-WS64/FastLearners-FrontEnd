import 'package:fastlearners_frontend_flutter/community_forum.dart';
import 'package:fastlearners_frontend_flutter/modelo/repository.dart';
import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:fastlearners_frontend_flutter/viewrepositories_Screen.dart';
import 'package:flutter/material.dart';
import 'database/api_rest_service.dart';
import 'home_screen.dart';
import 'repository_screen.dart'; // Asegúrate de importar la pantalla del repositorio

class CreateRepositoryScreen extends StatefulWidget {
  @override
  _CreateRepositoryScreenState createState() => _CreateRepositoryScreenState();
}

class _CreateRepositoryScreenState extends State<CreateRepositoryScreen> {

  final ApiRestService _apiService = ApiRestService();

  final _formKey = GlobalKey<FormState>();

  String? _repositoryName;
  String? _description;
  String? _visibility = 'Seleccionar';

  bool _includeReadme = false;
  bool _includeGitignore = false;

  String? _collaborators;

  Future<void> _createRepository(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Repositorio "$_repositoryName" creado exitosamente')),
      );

      final newRepo = Repositorio(
        id: 0,
        name: _repositoryName!,
        description: _description ?? 'Sin descripción',
        visibility: _visibility!,
        includeReadme: _includeReadme,
        includeGitignore: _includeGitignore,
        collaborators: _collaborators ?? 'Sin colaboradores',
      );
      
      var repository = await _apiService.insertRepository(newRepo);

      if (repository == null){
        return;
      }

      var repositoryId = repository.id!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RepositoryScreen(
            repositoryId: repositoryId,
            repositoryName: _repositoryName!,
            description: _description ?? 'Sin descripción',
            visibility: _visibility!,
            includeReadme: _includeReadme,
            includeGitignore: _includeGitignore,
            collaborators: _collaborators ?? 'Sin colaboradores',
          ),
        ),
      );
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Crear un nuevo repositorio',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre del repositorio',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del repositorio';
                  }
                  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                    return 'El nombre no puede contener caracteres especiales o números';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repositoryName = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Visibilidad del repositorio',
                  border: OutlineInputBorder(),
                ),
                value: _visibility,
                items: ['Seleccionar', 'Publico', 'Privado']
                    .map((visibility) => DropdownMenuItem(
                  value: visibility,
                  child: Text(visibility),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _visibility = value;
                  });
                },
                validator: (value) {
                  if (value == null || value == 'Seleccionar') {
                    return 'Por favor seleccione la visibilidad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Colaboradores (colocar correos)',
                  hintText: 'ej: user@example.com ; otro@correo.com',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _collaborators = value;
                },
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    var emails = value.split(';');
                    for (var email in emails) {
                      email = email.trim();
                      if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(email)) {
                        return 'Ingrese correos válidos separados por ;';
                      }
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Crear este repositorio con:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: Text('archivo README.md'),
                value: _includeReadme,
                onChanged: (bool? value) {
                  setState(() {
                    _includeReadme = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('archivo .gitignore'),
                value: _includeGitignore,
                onChanged: (bool? value) {
                  setState(() {
                    _includeGitignore = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _createRepository(context); // Ahora pasamos el 'context' correctamente
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  ),
                  child: Text(
                    'Crear repositorio',
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