import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
                width: 500,
                child:
                Column(
                    children: <Widget>[

                      const Text('Bienvenido de nuevo, usuario!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),

                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Te podrá interesar...',
                            style: TextStyle(fontSize: 15)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          width: 180,
                          height: 180,
                          decoration:
                          const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/home/home_image.png"),
                                  fit: BoxFit.cover)
                          )
                      ),
                      const SizedBox(height: 20),
                      const Text("""Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries""",
                          textAlign: TextAlign.justify),
                      const SizedBox(height: 20),
                      const Text("Vistos recientemente:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                      const SizedBox(height: 20),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                                width: 300,
                                height: 180,
                                decoration:
                                const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/home/home_image.png"),
                                        fit: BoxFit.cover)
                                )
                            ),
                            const SizedBox(height: 20),
                            Container(
                                width: 300,
                                height: 180,
                                decoration:
                                const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/home/home_image.png"),
                                        fit: BoxFit.cover)
                                )
                            ),
                          ],

                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                )
            )
        )
      )
    );
  }
}