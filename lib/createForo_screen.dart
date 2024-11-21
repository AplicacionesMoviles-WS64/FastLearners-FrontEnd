import 'package:flutter/material.dart';

class ForumCreateScreen extends StatefulWidget {
  final int userId;

  const ForumCreateScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ForumCreateScreenState createState() => _ForumCreateScreenState();
}

class _ForumCreateScreenState extends State<ForumCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _savePost() {
    if (_formKey.currentState!.validate()) {
      final post = {
        'postTitle': _titleController.text,
        'postBody': _bodyController.text,
        'userId': widget.userId,
      };

      // Aquí puedes implementar la lógica para guardar el post en el backend

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post creado con éxito')),
      );
      Navigator.pop(context, post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Post'),
        backgroundColor: Color.fromRGBO(254, 95, 85, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Título del Post',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Ingrese el título del post',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título no puede estar vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Contenido del Post',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _bodyController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Ingrese el contenido del post',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El contenido no puede estar vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _savePost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  ),
                  child: Text(
                    'Guardar Post',
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