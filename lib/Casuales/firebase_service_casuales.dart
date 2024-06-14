import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getCasuales() async {
  List<Map<String, dynamic>> casuales = [];
  CollectionReference collectionReferenceCasuales = db.collection("Casuales");
  QuerySnapshot queryCasuales = await collectionReferenceCasuales.get();

  queryCasuales.docs.forEach((documento) {
    // Verificar si los datos no son nulos y convertirlos a Map<String, dynamic>
    Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

    // Añadir los datos a la lista solo si no son nulos
    if (data != null) {
      casuales.add(data);
    }
  });
  return casuales;
}

Future<void> addCasual(String name, String description, double price, String colors, String image) async {
  try {
    await FirebaseFirestore.instance.collection('Casuales').add({
      'name': name,
      'description': description,
      'price': price,
      'colors': colors,
      'image': image,
    });
    print('Zapatilla casual agregada correctamente');
  } catch (e) {
    print('Error al agregar la zapatilla casual: $e');
    rethrow; // Puedes manejar este error como desees en tu aplicación
  }
}

Future<void> updateCasual(String id, String name, String description, double price, String colors, String image) async {
  try {
    await FirebaseFirestore.instance.collection('Casuales').doc(id).update({
      'name': name,
      'description': description,
      'price': price,
      'colors': colors,
      'image': image,
    });
    print('Zapatilla casual actualizada correctamente');
  } catch (e) {
    print('Error al actualizar la zapatilla casual: $e');
    rethrow; // Puedes manejar este error como desees en tu aplicación
  }
}
// Método para eliminar una zapatilla casual (DELETE)
Future<void> deleteCasual(String id) async {
  try {
    await FirebaseFirestore.instance.collection('Casuales').doc(id).delete();
    print('Zapatilla casual eliminada correctamente');
  } catch (e) {
    print('Error al eliminar la zapatilla casual: $e');
    rethrow; // Puedes manejar este error como desees en tu aplicación
  }
}
