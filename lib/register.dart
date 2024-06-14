import 'package:flutter/material.dart';
import 'package:menu2/http.dart'; 
import 'package:menu2/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();
  String? _cedula, _nombres, _apellidos, _genero, _estadoCivil, _password;
  bool _terminosAceptados = false;

  @override
  void dispose() {
    _emailController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }

  void _onSiguientePressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String fechaNacimiento = _fechaNacimientoController.text;

      bool registered = await registerUser(
        context,
        _cedula!,
        _nombres!,
        _apellidos!,
        _emailController.text,
        _password!,
        _genero!,
        _estadoCivil!,
        fechaNacimiento,
        _terminosAceptados,
      );
      if (registered) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error al registrar. Por favor, intenta de nuevo más tarde.'),
          ),
        );
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contraseña es obligatoria';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName es obligatorio';
    }
    if (value.length < 5) {
      return '$fieldName debe tener al menos 5 caracteres';
    }
    return null;
  }

  bool verificarCedula(String cedula) {
    if (cedula.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(cedula)) {
      return false;
    }

    List<int> coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
    int suma = 0;

    for (int i = 0; i < 9; i++) {
      int digito = int.parse(cedula[i]) * coeficientes[i];
      if (digito >= 10) {
        digito -= 9;
      }
      suma += digito;
    }

    int digitoVerificador = int.parse(cedula[9]);
    int decenaSuperior = ((suma + 9) ~/ 10) * 10;
    int digitoCalculado = decenaSuperior - suma;

    if (digitoCalculado == 10) {
      digitoCalculado = 0;
    }

    return digitoVerificador == digitoCalculado;
  }

  String? _validateCedula(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cédula es obligatoria';
    }
    if (!verificarCedula(value)) {
      return 'Cédula no es válida';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Correo electrónico es obligatorio';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido';
    }
    return null;
  }

  String? _validateFecha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fecha de nacimiento es obligatoria';
    }
    try {
      DateTime.parse(value);
    } catch (_) {
      return 'Fecha inválida';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("Img/perfil.jpeg"),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Registro de Usuario",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Freeman',
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    decoration: _buildInputDecoration("Cédula", Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: _validateCedula,
                    onSaved: (valor) => _cedula = valor,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: _buildInputDecoration("Nombres", Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => _validateNotEmpty(value, 'Nombres'),
                    onSaved: (valor) => _nombres = valor,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        _buildInputDecoration("Apellidos", Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => _validateNotEmpty(value, 'Apellidos'),
                    onSaved: (valor) => _apellidos = valor,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: _buildInputDecoration(
                        "Correo electrónico", Icons.email),
                    style: const TextStyle(color: Colors.white),
                    controller: _emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: _buildInputDecoration("Contraseña", Icons.lock),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: _validatePassword,
                    onSaved: (valor) => _password = valor,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _fechaNacimientoController,
                    decoration: _buildInputDecoration(
                        "Fecha de nacimiento (YYYY-MM-DD)",
                        Icons.calendar_today),
                    validator: _validateFecha,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (valor) =>
                        _fechaNacimientoController.text = valor ?? '',
                  ),
                  const SizedBox(height: 20.0),
                  _buildGeneroField(),
                  const SizedBox(height: 20.0),
                  _buildEstadoCivilField(),
                  const SizedBox(height: 20.0),
                  CheckboxListTile(
                    title: const Text('Acepto los términos y condiciones',
                        style: TextStyle(color: Colors.white)),
                    value: _terminosAceptados,
                    onChanged: (bool? value) {
                      setState(() {
                        _terminosAceptados = value ?? false;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState
                              ?.reset(); // Resetea el formulario
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE94560),
                          fixedSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text("Salir",
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: _onSiguientePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF53DD6C),
                          fixedSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text("Siguiente",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      suffixIcon: Icon(icon, color: Colors.white),
      filled: true,
      fillColor: Colors.white24,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget _buildGeneroField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Género',
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        ListTile(
          title: const Text('Masculino', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Masculino',
            groupValue: _genero,
            onChanged: (String? value) {
              setState(() {
                _genero = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text('Femenino', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Femenino',
            groupValue: _genero,
            onChanged: (String? value) {
              setState(() {
                _genero = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text('Otro', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Otro',
            groupValue: _genero,
            onChanged: (String? value) {
              setState(() {
                _genero = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildEstadoCivilField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Estado Civil',
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        ListTile(
          title: const Text('Soltero', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Soltero',
            groupValue: _estadoCivil,
            onChanged: (String? value) {
              setState(() {
                _estadoCivil = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text('Casado', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Casado',
            groupValue: _estadoCivil,
            onChanged: (String? value) {
              setState(() {
                _estadoCivil = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        ListTile(
          title:
              const Text('Divorciado', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Divorciado',
            groupValue: _estadoCivil,
            onChanged: (String? value) {
              setState(() {
                _estadoCivil = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text('Viudo', style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            value: 'Viudo',
            groupValue: _estadoCivil,
            onChanged: (String? value) {
              setState(() {
                _estadoCivil = value;
              });
            },
            activeColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
