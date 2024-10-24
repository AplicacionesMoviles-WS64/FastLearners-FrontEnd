import 'package:fastlearners_frontend_flutter/home_screen.dart';
import 'package:flutter/material.dart';

class SelectPlanScreen extends StatefulWidget {
  @override
  SelectPlanScreenState createState() => SelectPlanScreenState();
}

class SelectPlanScreenState extends State<SelectPlanScreen> {
  String selectedPlan = "";

  void buttonEvent(String plan) {
    setState(() {
      selectedPlan = plan;
    });

    // Diálogo de confirmación antes de redirigir al usuario
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar selección'),
        content: Text('¿Quieres elegir el $plan?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Cierra el diálogo
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Cierra el diálogo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget buildPlanCard(String title, String price, List<String> features) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: features
                .map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    feature,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => buttonEvent(title),
            child: const Text(
              "Elegir plan",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(254, 95, 85, 1),
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                "Plan Básico",
                "S/.00.00",
                ["Característica 1", "Característica 2", "Característica 3", "Característica 4"],
              ),
              buildPlanCard(
                "Plan Estándar",
                "S/.20.00",
                ["Característica 1", "Característica 2", "Característica 3", "Característica 4"],
              ),
              buildPlanCard(
                "Plan Premium",
                "S/.40.00",
                ["Característica 1", "Característica 2", "Característica 3", "Característica 4"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}