import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class SelectPlanScreen extends StatefulWidget{

  @override
  SelectPlanScreenState createState() => SelectPlanScreenState();
}


class SelectPlanScreenState extends State<SelectPlanScreen>{


   buttonEvent(){
     
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text('Planes')
        ), 
        body: Center(child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text("Planes disponibles!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 20),
                  Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),

                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          alignment: Alignment.centerLeft,
                          child: const Text("S/.00.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42))),
                        const Divider(
                          thickness: 2.0,
                          indent: 15.0,
                          endIndent: 15.0,
                          color: Colors.black
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 14, top: 10),
                          child: Row(
                            children: [
                              Row(children: [
                                Container(width: 15, height: 15, color: Colors.white),
                                const SizedBox(width: 8),
                                const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                              ]),
                              ]
                          )
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 14, top: 5),
                            child: Row(
                                children: [
                                  Row(children: [
                                    Container(width: 15, height: 15, color: Colors.white),
                                    const SizedBox(width: 8),
                                    const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                  ]),
                                ]
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 14, top: 5),
                            child: Row(
                                children: [
                                  Row(children: [
                                    Container(width: 15, height: 15, color: Colors.white),
                                    const SizedBox(width: 8),
                                    const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                  ]),
                                ]
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 14, top: 5),
                            child: Row(
                                children: [
                                  Row(children: [
                                    Container(width: 15, height: 15, color: Colors.white),
                                    const SizedBox(width: 8),
                                    const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                  ]),
                                ]
                            )
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(onPressed: buttonEvent, child: Text("Elegir plan"))
                      ]
                    )
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),

                            Container(
                                padding: const EdgeInsets.only(left: 10, top: 15),
                                alignment: Alignment.centerLeft,
                                child: const Text("S/.00.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42))),
                            const Divider(
                                thickness: 2.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: Colors.black
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 10),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(onPressed: buttonEvent, child: Text("Elegir plan"))
                          ]
                      )
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),

                            Container(
                                padding: const EdgeInsets.only(left: 10, top: 15),
                                alignment: Alignment.centerLeft,
                                child: const Text("S/.00.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42))),
                            const Divider(
                                thickness: 2.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: Colors.black
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 10),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 14, top: 5),
                                child: Row(
                                    children: [
                                      Row(children: [
                                        Container(width: 15, height: 15, color: Colors.white),
                                        const SizedBox(width: 8),
                                        const Text("Lorem impsum", style: TextStyle(fontSize: 18))
                                      ]),
                                    ]
                                )
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(onPressed: buttonEvent, child: Text("Elegir plan"))
                          ]
                      )
                  )

                ]
            )
        )
        )
    );

  }
}