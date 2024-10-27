import 'package:fastlearners_frontend_flutter/profile_screen.dart';
import 'package:fastlearners_frontend_flutter/viewrepositories_Screen.dart';
import 'package:flutter/material.dart';
import 'community_forum.dart';
import 'createrepository_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Usuario";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                color: Color.fromRGBO(189, 213, 234, 1)
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
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
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
              leading: Icon(Icons.create),
              title: Text('Ver repositorios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepositoryListScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Foro de la comunidad'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityForum()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: screenWidth * 0.9,
            child: Column(
              children: <Widget>[
                Text(
                  '¡Bienvenido de nuevo, $userName!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Te podría interesar...',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home/angular.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Angular es un framework de desarrollo web de código abierto, mantenido por Google, que se utiliza para crear aplicaciones web de una sola página (SPA, por sus siglas en inglés). ",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Vistos recientemente:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
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
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/home/html.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/home/css.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}