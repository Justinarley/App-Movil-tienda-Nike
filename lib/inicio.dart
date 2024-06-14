import 'package:flutter/material.dart';
import 'package:menu2/Casuales/casuales.dart';
import 'package:menu2/configuraciones.dart';
import 'package:menu2/contactos.dart';
import 'package:menu2/Deportivos/deportivos.dart';
import 'package:menu2/home.dart';
import 'package:menu2/login.dart';
import 'package:menu2/navbar.dart';

void main() => runApp(Inicio(
      nombreObtenidoDelInicioDeSesion: '',
      emailObtenidoDelInicioDeSesion: '',
    ));

class Inicio extends StatelessWidget {
  final String nombreObtenidoDelInicioDeSesion;
  final String emailObtenidoDelInicioDeSesion;

  const Inicio({
    required this.nombreObtenidoDelInicioDeSesion,
    required this.emailObtenidoDelInicioDeSesion,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ),
      routes: {
        "/login": (context) => const Login(),
        "/home": (context) => const Home(),
        "/deportivos": (context) => const Deportivos(),
        "/casuales": (context) => const Casuales(),
        "/configuraciones": (context) => const Configuraciones(),
        "/contactos": (context) => const Contactos(),
      },
      title: 'Tienda de Zapatillas Nike',
      home: Scaffold(
        drawer: const Navbar(
          accountName: '',
          accountEmail: '',
          ),
        appBar: AppBar(
          title: const Text('Tienda de Zapatillas Nike'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Bienvenido a la tienda de zapatillas Nike!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Explora nuestra amplia selección de zapatillas deportivas y casuales.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                'Estamos desarrollando una aplicación móvil en Flutter para una tienda de zapatillas Nike. '
                'La aplicación incluye funcionalidades para que los usuarios se registren y puedan iniciar sesión, '
                'facilitando así la gestión de cuentas de los clientes.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
