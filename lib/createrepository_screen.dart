import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'repository_screen.dart'; // Asegúrate de importar la pantalla del repositorio

class CreateRepositoryScreen extends StatefulWidget {
  @override
  _CreateRepositoryScreenState createState() => _CreateRepositoryScreenState();
}

class _CreateRepositoryScreenState extends State<CreateRepositoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _repositoryName;
  String? _description;
  String? _visibility = 'Seleccionar'; // Valor inicial del Dropdown
  bool _includeReadme = false;
  bool _includeGitignore = false;
  String? _collaborators;

  void _createRepository(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Muestra un SnackBar de confirmación antes de redirigir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Repositorio "$_repositoryName" creado exitosamente')),
      );

      // Después de crear el repositorio, redirige a la pantalla de repositorio
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RepositoryScreen(
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
                color: Colors.blue,
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
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {},
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
                items: ['Seleccionar', 'Público', 'Privado']
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