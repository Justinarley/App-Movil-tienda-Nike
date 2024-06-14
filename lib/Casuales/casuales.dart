import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu2/Casuales/editar_casuales.dart';
import 'package:menu2/Casuales/firebase_service_casuales.dart'; // Asegúrate de importar el archivo correcto

class Casuales extends StatelessWidget {
  const Casuales({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Zapatillas Casuales'), // Ajusta el título según sea necesario
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Casuales').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Algo salió mal'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: data.size,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarCasuales(
                        shoeId: data.docs[index].id,
                        shoeData: data.docs[index],
                      ),
                    ),
                  ),
                  onLongPress: () => (context, data.docs[index].id),
                  child: ProductCard(
                      image: data.docs[index]['image'],
                      name: data.docs[index]['name'],
                      description: data.docs[index]['description'],
                      price: '\$${data.docs[index]['price']}',
                      colors: data.docs[index]['colors'],
                      onDelete: () =>
                          _deleteCasual(context, data.docs[index].id)),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCasuales(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCasuales(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarCasuales(),
      ),
    );
  }

  void _deleteCasual(BuildContext context, String id) {
    deleteCasual(id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Zapatilla casual eliminada'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al eliminar la zapatilla casual: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  final String colors;
  final VoidCallback onDelete;

  const ProductCard({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.colors,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Colores: $colors',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
