//import 'package:carousel_slider/carousel_slider.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:flutter/material.dart';
//import 'package:newgarden/modelos/modelo_moderador.dart';
//import 'anadir_resena.dart';
//import 'package:newgarden/controlador/controlador_verIplanta.dart';
//import 'menu_mod.dart';
import 'package:newgarden/modelos/modelo_cuenta.dart';
//import 'package:newgarden/modelos/modelo_resena.dart';
import 'package:newgarden/controlador/controlador_verlistres.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';

import 'package:newgarden/controlador/controlador_bloqus.dart';

//import 'package:newgarden/vistas/boton_lateral.dart';

//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:flutter/material.dart';
//import 'package:prueba_lol/modelos/modelo_planta.dart';

class BlockUserScreen extends StatefulWidget {
  final Cuenta moderador;
  const BlockUserScreen({Key? key, required this.moderador}) : super(key: key);

  @override
  State<BlockUserScreen> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUserScreen> {
  final BloquearUs listaUsers = BloquearUs();
  List users = [];

  @override
  void initState() {
    super.initState();
    getusuario(); // Accede al miembro 'widget' en initState
  }

  Future<String> obtenerUsuario(int iduser) async {
    Usuario usuario = Usuario(0, '', '', '', 0, true);
    List<dynamic> nombre = await usuario.getusuarionom(iduser);
    String username = nombre[0];
    return username;
  }

  void getusuario() async {
    List<dynamic>? allUsers = await listaUsers.getusuario();
    setState(() {
      users = allUsers[0];
    });
  }

  void blockUser(int id) async {
    setState(() {
      listaUsers.bloquearus(id);
      users.removeWhere((users) => users.id == id);
      //plantas.removeWhere((plantas) => plantas[0] == idcoleccion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios', style: TextStyle(fontSize: 23)),
        flexibleSpace: buildGradientAppBar(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      /*
      bottomNavigationBar: Container(
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 35, 104, 29),
              Color.fromARGB(255, 19, 53, 36)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      */
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Usuario currentUsuario = users[index];
                return Column(
                  children: [
                    ListTile(
                      title: ListBody(children: [
                        Text(
                          "Nombre (id) : ${currentUsuario.nombre} (${currentUsuario.id})",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 20, 6),
                              fontSize: 18),
                        ),
                        Text(
                          "Correo: ${currentUsuario.correo}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 20, 6),
                              fontSize: 18),
                        ),
                        //Usuario(int id, String nombre, String correo, String password, int tipo, this.estado)
                      ]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Llamamos a la función eliminarResena al presionar el botón
                          blockUser(currentUsuario.id);
                        },
                      ),
                    ),
                    const Divider(), // Agregar un Divider entre los elementos de la lista
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
