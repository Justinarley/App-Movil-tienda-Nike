import 'package:flutter/material.dart';

class Configuraciones extends StatelessWidget {
  const Configuraciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text('Recibir notificaciones de la tienda'),
            value: true,
            onChanged: (bool value) {
              // Lógica para manejar el cambio de estado
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Idioma'),
            subtitle: const Text('Selecciona el idioma'),
            onTap: () {
              // Lógica para seleccionar el idioma
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacidad y Seguridad'),
            subtitle: const Text('Configura tus preferencias de privacidad'),
            onTap: () {
              // Lógica para configurar la privacidad
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ayuda'),
            subtitle: const Text('Centro de ayuda y soporte'),
            onTap: () {
              // Lógica para abrir el centro de ayuda
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            subtitle: const Text('Información sobre la aplicación'),
            onTap: () {
              // Lógica para mostrar información sobre la aplicación
            },
          ),
        ],
      ),
    );
  }
}
