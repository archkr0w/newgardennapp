import 'package:flutter/material.dart';
import '../controlador/controlador_registro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
//import 'login.dart';

class Registro extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Registro> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();

  Registrocontroller registro = Registrocontroller();


  /*Future<void> _saveUserToDatabase(
      String nombre, String email, String password) async {
    final connection = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'new_garden',
      username: 'postgres',
      password: '3222',
    );
    //se tiene que verificar que no exista el correo ya en la base de datos
    try {
      await connection.open();
      await connection.query(
        "INSERT INTO cuenta (nombre, apellido, email, contra) VALUES (@nombre, @email, @contra)",
        substitutionValues: {
          "nombre": nombre,
          "email": email,
          "contra": password
        },
      );

      await connection.close();
    } catch (e) {
      print("Error: $e");
      // Aquí puedes mostrar un mensaje al usuario indicando que hubo un error al registrar su cuenta.
    }
  }*/

  /*void RegistroController() async {
    String nombre = _nombreController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    await _saveUserToDatabase(nombre, email, password);

    // Aquí puedes realizar la lógica para enviar los datos a la base de datos PostgreSQL

    // utilizando una nueva función similar a _validateUser en LoginPage.
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Registro",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
                 
              CustomTextField(
                  controller: _nombreController, 
                  title: "Nombre"
                  ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: _emailController, 
                  title: "Correo"
                  ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: _passwordController, 
                  title: "Contraseña"
                  ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: _passwordController2, 
                  title: "Repita contraseña"
                  ),
              const SizedBox(
                height: 10,
              ),

              CustomButton(
                buttonText: const Text(
                        "Registrarse",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                  ,
                  onpressed: () async {
                    //validar que el correo no exista en la base de datos
                    //si no existe se hace lo de abajo
                  if (_nombreController.text.isEmpty   ||
                      _emailController.text.isEmpty    || 
                      _passwordController.text.isEmpty ||
                      _passwordController2.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Hay campos de texto vacios",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                  }else 
                  if(_passwordController.text.length < 4){
                    Fluttertoast.showToast(
                          msg: "La contraseña debe tener al menos 4 caracteres",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1
                        );
                  }else 
                  if(_passwordController.text != _passwordController2.text){
                      Fluttertoast.showToast(
                          msg: "Las contraseñas no coinciden",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1
                        );
                    }
                    else 
                    if(await registro.validateEmail(_emailController.text) == false){
                        registro.registro(
                          _emailController.text,
                          _nombreController.text,
                          _passwordController.text);
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "Registrado con exito",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1
                          );
                          
                    }else{
                        Fluttertoast.showToast(
                            msg: "El correo ya existe ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1
                          );
                    }
                    
                  },
              ),
              /*
              ElevatedButton(
                  onPressed: () async {
                    //validar que el correo no exista en la base de datos
                    //si no existe se hace lo de abajo
                    if(await registro.validateEmail(_emailController.text) == false){
                        registro.registro(
                          _emailController.text,
                          _nombreController.text,
                          _passwordController.text);
                        Navigator.of(context).pop();
                          
                    }else{
                        Fluttertoast.showToast(msg: "El correo ya existe ");
                        Fluttertoast.showToast(
                            msg: "El correo ya existe ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1
                          );
                    }
                    
                  },
                  child: Text('Registrarse')
                ),
                */
            ],
          ),
        ),
      ),
    );
  }
}
