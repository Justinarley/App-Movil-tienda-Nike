import 'package:flutter/material.dart';

class Contactos extends StatelessWidget {
  const Contactos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Llamar a Soporte'),
            subtitle: const Text('Número: +1 800 123 4567'),
            onTap: () {
              // Lógica para llamar al número de soporte
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Correo Electrónico'),
            subtitle: const Text('Email: soporte@nike.com'),
            onTap: () {
              // Lógica para enviar un correo electrónico
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Visítanos'),
            subtitle: const Text('Dirección: 123 Calle Principal, Ciudad, País'),
            onTap: () {
              // Lógica para abrir ubicación en mapa
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat en Vivo'),
            subtitle: const Text('Habla con uno de nuestros agentes'),
            onTap: () {
              // Lógica para iniciar el chat en vivo
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Enviar Retroalimentación'),
            subtitle: const Text('Cuéntanos tu experiencia'),
            onTap: () {
              // Lógica para enviar retroalimentación
            },
          ),
        ],
      ),
    );
  }
}
