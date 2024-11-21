import 'dart:ffi';

import 'package:fastlearners_frontend_flutter/home_screen.dart';
import 'package:fastlearners_frontend_flutter/pay_method_screen.dart';
import 'package:flutter/material.dart';

import 'database/api_rest_service.dart';
import 'dart:ffi';
import 'dart:ffi';

import 'package:fastlearners_frontend_flutter/home_screen.dart';
import 'package:fastlearners_frontend_flutter/pay_method_screen.dart';
import 'package:flutter/material.dart';

import 'database/api_rest_service.dart';


class SelectPlanScreen extends StatefulWidget {
  @override
  SelectPlanScreenState createState() => SelectPlanScreenState();

  final int userId;

  const SelectPlanScreen({
    Key? key,
    required this.userId
  }) : super(key: key);
}

class SelectPlanScreenState extends State<SelectPlanScreen> {


  final ApiRestService _apiService = ApiRestService();

  String selectedPlan = "";
  

  void buttonEvent(String plan, String title) {
    setState(() {
      selectedPlan = plan;
    });

    // Diálogo de confirmación antes de redirigir al usuario
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar selección'),
        content: Text('¿Quieres elegir el $title?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _apiService.updateUserMembership(widget.userId, selectedPlan);
              Navigator.pop(context); // Cierra el diálogo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayMethodScreen()),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget buildPlanCard(String id, String title, String price, List<Map<String, IconData>> features) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(189, 213, 234, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
          ),
          const Divider(thickness: 2.0, color: Colors.black),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(feature.values.first, color: Colors.black), // Íconos en negro
                  const SizedBox(width: 8),
                  Text(
                    feature.keys.first,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => buttonEvent(id, title), // Al presionar se abre el diálogo
            child: const Text(
              "Elegir plan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(254, 95, 85, 1),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planes'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Planes disponibles!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 20),
              // Planes
              buildPlanCard(
                "BASIC",
                "Plan Básico",
                "S/.15.00",
                [
                  {"25 videos por mes": Icons.video_library},
                  {"10 repositorios por mes": Icons.folder},
                  {"Acceso a la documentación": Icons.book},
                  {"Acceso al foro": Icons.forum},
                ],
              ),
              buildPlanCard(
                "REGULAR",
                "Plan Estándar",
                "S/.20.00",
                [
                  {"50 videos por mes": Icons.video_library},
                  {"20 repositorios por mes": Icons.folder},
                  {"Acceso a la documentación": Icons.book},
                  {"Acceso al foro": Icons.forum},
                ],
              ),
              buildPlanCard(
                "PREMIUM",
                "Plan Premium",
                "S/.50.00",
                [
                  {"Videos ilimitados": Icons.video_library},
                  {"Repositorios ilimitados": Icons.folder},
                  {"Acceso a la documentación": Icons.book},
                  {"Acceso al foro": Icons.forum},
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

