import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> registerUser(
    BuildContext context,
    String cedula,
    String nombres,
    String apellidos,
    String email,
    String password,
    String genero,
    String estadoCivil,
    String fechaNacimiento,
    bool terminosAceptados) async {
  const url = 'http://localhost:3000/register';

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'cedula': cedula,
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
      'password': password,
      'genero': genero,
      'estado_civil': estadoCivil,
      'fecha_nacimiento': fechaNacimiento,
      'terminos_aceptados': terminosAceptados,
    }),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    print('Error: ${response.statusCode}');
    print('Response body: ${response.body}');
    return false;
  }
}
Future<bool> loginUser(String email, String password) async {
  const url = 'http://localhost:3000/login';

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Parsear la respuesta JSON
    var responseData = jsonDecode(response.body);
    return responseData['success'];
  } else {
    print('Error: ${response.statusCode}');
    print('Response body: ${response.body}');
    return false;
  }
}
