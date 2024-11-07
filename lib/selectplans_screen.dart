import 'package:flutter/material.dart';
import 'package:fastlearners_frontend_flutter/pay_method_screen.dart';
import 'database/db.dart';

class SelectPlanScreen extends StatefulWidget {
  final String email;

  SelectPlanScreen({required this.email});

  @override
  SelectPlanScreenState createState() => SelectPlanScreenState();
}

class SelectPlanScreenState extends State<SelectPlanScreen> {
  final DB _databaseHelper = DB();
  String selectedPlan = "";

  void buttonEvent(String plan) {
    setState(() {
      selectedPlan = plan;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar selección'),
        content: Text('¿Quieres elegir el $plan?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Cierra el diálogo

              // Actualizar el plan en la base de datos
              try {
                await _databaseHelper.updateUserPlan(widget.email, plan);
                print("Plan actualizado exitosamente");
              } catch (e) {
                print("Error al actualizar el plan: $e");
              }

              // Navegar a PayMethodScreen y pasar el email
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayMethodScreen(email: widget.email),
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget buildPlanCard(String title, String price, List<Map<String, IconData>> features) {
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
                  Icon(feature.values.first, color: Colors.black),
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
            onPressed: () => buttonEvent(title),
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
              buildPlanCard(
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