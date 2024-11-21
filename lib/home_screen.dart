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

  final String userEmail = "usuario@email.com";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 4, // Sombra debajo del AppBar
        backgroundColor: Color.fromRGBO(254, 95, 85, 1), // Color principal
        title: Text(
          'FastLearners', // Cambia por el título que prefieras
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Centra el título
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notificaciones no implementadas')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(userName: '', email: ''),
                ),
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
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(189, 213, 234, 1), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'usuario@email.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Página de inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.create, color: Colors.green),
              title: Text('Crear repositorio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRepositoryScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.folder, color: Colors.orange),
              title: Text('Ver repositorios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RepositoryListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.forum, color: Colors.purple),
              title: Text('Foro de la comunidad'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityForum()));
              },
            ),
          ],
        ),
      ),









      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSeparator('Te podría interesar'),
            _buildFeaturedSection(screenWidth),
            _buildSeparator('Vistos recientemente'),
            _buildRecentlyViewedSection(screenWidth),
          ],
        ),
      ),
    );
  }



  Widget _buildSeparator(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Angular',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: screenWidth,
            height: screenWidth * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home/angular.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Angular es un framework de desarrollo web de código abierto, mantenido por Google, que se utiliza para crear aplicaciones web de una sola página.",
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedSection(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecentlyViewedItem(screenWidth, "HTML", "assets/home/html.png"),
          SizedBox(height: 16),
          _buildRecentlyViewedItem(screenWidth, "CSS", "assets/home/css.png"),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedItem(double screenWidth, String title, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: screenWidth,
          height: screenWidth * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ],
    );
  }
}