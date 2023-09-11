import 'package:newgarden/components/custom_button.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:newgarden/components/custom_text_field.dart';
import 'package:newgarden/controlador/controlador_login.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
import 'package:newgarden/vistas/boton_lateral.dart';
import 'package:newgarden/vistas/menu_mod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:newgarden/modelos/modelo_cuenta.dart';
//import 'package:newgarden/modelos/modelo_moderador.dart';

import 'package:newgarden/controlador/controlador_getdatosusu.dart';

//import 'package:prueba_lol/modelos/modelo_cuenta.dart';
//import '../config/rutas.dart' as route;
//import 'package:prueba_lol/controlador/controlador_login.dart';
import 'registro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _correoController = TextEditingController();
  final _passController = TextEditingController();

  final LoginController login = LoginController();
  final ObtenerUsu usuarioC = ObtenerUsu();
  List usuario = [];
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        flexibleSpace: buildGradientAppBar(),
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
              const SizedBox(
                height: 30,
              ),
              CustomTextField(controller: _correoController, title: "Correo"),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: _obscureText,
                controller: _passController,
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: true
                    ? const Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    // ignore: dead_code
                    : const Center(child: CircularProgressIndicator()),
                onpressed: () async {
                  List<dynamic>? listadoCuenta = await login.login(
                      _correoController.text, _passController.text);

                  if (listadoCuenta != null) {
                    //pertenece a usuario
                    if (listadoCuenta[0][4] == 2) {
                      List<dynamic> auxusu =
                          await usuarioC.getdatausuario(listadoCuenta[0][2]);
                      Usuario cuentaUsu = auxusu[0];
                      //abajo para detectar que no esté block
                      if (cuentaUsu.estado == true) {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) =>
                                BotonLateral(usuario: cuentaUsu));
                        Navigator.push(context, route);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Usuario bloqueado",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      }

                      //abajo para detectar que es admin
                    } else if (listadoCuenta[0][4] == 1) {
                      List<dynamic> auxusu =
                          await usuarioC.getdatamod(listadoCuenta[0][2]);
                      Cuenta cuentaMod = auxusu[0];
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => MenuMod(moderador: cuentaMod));
                      Navigator.push(context, route);
                    }
                  } else if (_correoController.text.isEmpty &&
                      _passController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Por favor Ingrese los Datos",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                  } else if (_correoController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Por favor Ingrese un Correo",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                  } else if (_passController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Por favor Ingrese una Contraseña",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                  } else {
                    Fluttertoast.showToast(
                        msg: "No Existe la Cuenta",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No tienes cuenta?"),
                  TextButton(
                    onPressed: () {
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (context) => Registro());
                      Navigator.push(context, route);
                    },
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
