import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getCliente() async {
  List<Map<String, dynamic>> cliente = [];
  CollectionReference collectionReferenceCliente = db.collection("Deportivos");
  QuerySnapshot queryCliente = await collectionReferenceCliente.get();

  queryCliente.docs.forEach((documento) {
    // Verificar si los datos no son nulos y convertirlos a Map<String, dynamic>
    Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

    // Añadir los datos a la lista solo si no son nulos
    if (data != null) {
      cliente.add(data);
    }
  });
  return cliente;
}

// Método para agregar una nueva zapatilla (POST)
Future<void> addShoe(String name, String description, double price, String colors, String image) async {
  try {
    await FirebaseFirestore.instance.collection('Deportivos').add({
      'name': name,
      'description': description,
      'price': price,
      'colors': colors,
      'image': image,
    });
    print('Zapatilla agregada correctamente');
  } catch (e) {
    print('Error al agregar la zapatilla: $e');
    rethrow; // Puedes manejar este error como desees en tu aplicación
  }
}
// Método para eliminar una zapatilla
Future<void> deleteShoe(String id) async {
  try {
    await FirebaseFirestore.instance.collection('Deportivos').doc(id).delete();
    print('Zapatilla eliminada correctamente');
  } catch (e) {
    print('Error al eliminar la zapatilla: $e');
    rethrow; // Puedes manejar este error como desees en tu aplicación
  }
}