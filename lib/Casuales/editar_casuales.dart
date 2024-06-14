import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu2/Casuales/firebase_service_casuales.dart';

class EditarCasuales extends StatefulWidget {
  final String? shoeId;
  final DocumentSnapshot? shoeData;

  EditarCasuales({this.shoeId, this.shoeData});

  @override
  _EditarCasualesState createState() => _EditarCasualesState();
}

class _EditarCasualesState extends State<EditarCasuales> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _colorsController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.shoeData != null) {
      _nameController.text = widget.shoeData!['name'];
      _descriptionController.text = widget.shoeData!['description'];
      _priceController.text = widget.shoeData!['price'].toString();
      _colorsController.text = widget.shoeData!['colors'];
      _imageController.text = widget.shoeData!['image'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoeId == null ? 'Añadir Zapatilla Casual' : 'Editar Zapatilla Casual'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _colorsController,
              decoration: InputDecoration(labelText: 'Colores'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCasuales,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCasuales() {
    final String name = _nameController.text;
    final String description = _descriptionController.text;
    final double price = double.parse(_priceController.text);
    final String colors = _colorsController.text;
    final String image = _imageController.text;

    if (widget.shoeId == null) {
      // Agregar nueva zapatilla casual (POST)
      addCasual(name, description, price, colors, image).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        print('Error al agregar la zapatilla casual: $error');
        // Manejo del error
      });
    } else {
      // Editar zapatilla casual existente (PUT)
      updateCasual(widget.shoeId!, name, description, price, colors, image).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        print('Error al actualizar la zapatilla casual: $error');
        // Manejo del error
      });
    }
  }
}
