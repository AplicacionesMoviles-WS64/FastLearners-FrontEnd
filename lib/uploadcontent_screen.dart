import 'package:flutter/material.dart';

import 'package:fastlearners_frontend_flutter/modelo/content.dart';

import 'database/api_rest_service.dart';

class UploadContentScreen extends StatefulWidget {
  final String repositoryName;

  const UploadContentScreen({
    Key? key,
    required this.repositoryName,
  }) : super(key: key);

  @override
  _UploadContentScreenState createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _contentType;
  String? _description;
  String? _visibility = 'Seleccionar';
  String? _collaborators;

  Future<void> _uploadContent() async {
    if (!_formKey.currentState!.validate()) return;

    // Guardar los datos del formulario
    _formKey.currentState!.save();

    // Crear una instancia de Content
    final content = Content(
      titleContent: _title ?? '',
      contentType: _contentType ?? '',
      description: _description ?? '',
      visibility: _visibility == 'Público' ? 'public' : 'private',
      collaborators: _collaborators ?? '',
      repositoryName: widget.repositoryName,
    );

    // Llama a createContent de ApiRestService
    final apiService = ApiRestService();
    await apiService.createContent(content.repositoryName, content.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido subido con éxito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Contenido a ${widget.repositoryName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subir contenido a FastLearners',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipo de contenido',
                  border: OutlineInputBorder(),
                ),
                items: ['Video', 'Artículo', 'Presentación']
                    .map((contentType) => DropdownMenuItem(
                  value: contentType,
                  child: Text(contentType),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _contentType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione el tipo de contenido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Visibilidad del contenido',
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
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _uploadContent,
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