import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatelessWidget {
  final String accountName = "Nike";
  final String accountEmail = "Nikeairforce@gmail.com";

  const Navbar({Key? key, required String accountName, required String accountEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("Img/homero.jpeg"),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text("Deportivos"),
            onTap: () {
              Navigator.pushNamed(context, "/deportivos");
            },
          ),
          ListTile(
            leading: const Icon(Icons.style),
            title: const Text("Casuales"),
            onTap: () {
              Navigator.pushNamed(context, "/casuales");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configuración"),
            onTap: () {
              Navigator.pushNamed(context, "/configuraciones");
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Contáctanos"),
            onTap: () {
              Navigator.pushNamed(context, "/contactos");
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar sesión"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Limpiar datos de usuario al cerrar sesión
              Navigator.pushNamed(context, "/login");
            },
          )
        ],
      ),
    );
  }
}
