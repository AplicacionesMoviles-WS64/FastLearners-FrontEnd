import 'package:flutter/material.dart';

class UploadContentScreen extends StatefulWidget {
  @override
  _UploadContentScreenState createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _contentType;
  String? _description;
  String? _visibility = 'Seleccionar'; // Valor inicial para la visibilidad
  String? _collaborators;
  String? _repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir contenido a FastLearners'),
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
                  labelText: 'Descripción (obligatorio)',
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
              ElevatedButton(
                onPressed: () {
                  // Acción para añadir archivos
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                ),
                child: Text('Añadir archivos', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Visibilidad del contenido',
                  border: OutlineInputBorder(),
                ),
                value: _visibility,
                items: ['Público', 'Privado']
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
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Vincular a un repositorio (opcional)',
                  hintText: 'ej: fastlearners-repo',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _repository = value;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Contenido subido con éxito')),
                      );
                    }
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