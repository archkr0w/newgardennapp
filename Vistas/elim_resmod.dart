//import 'package:carousel_slider/carousel_slider.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:newgarden/modelos/modelo_moderador.dart';
//import 'anadir_resena.dart';
//import 'package:newgarden/controlador/controlador_verIplanta.dart';
//import 'menu_mod.dart';
import 'package:newgarden/modelos/modelo_cuenta.dart';
import 'package:newgarden/modelos/modelo_resena.dart';
import 'package:newgarden/controlador/controlador_verlistres.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';

//import 'package:newgarden/vistas/boton_lateral.dart';

//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:flutter/material.dart';
//import 'package:prueba_lol/modelos/modelo_planta.dart';

class EliminarResModScreen extends StatefulWidget {
  final Cuenta moderador;
  const EliminarResModScreen({Key? key, required this.moderador})
      : super(key: key);

  @override
  State<EliminarResModScreen> createState() => _EliminarResModState();
}

class _EliminarResModState extends State<EliminarResModScreen> {
  final EliminarResModController listaResenas = EliminarResModController();
  List resenas = [];

  @override
  void initState() {
    super.initState();
    loadResenasPlant(); // Accede al miembro 'widget' en initState
  }

  void eliminarResena(int resenaid) async {
    setState(() {
      listaResenas.dirigeEliminarResena(resenaid);
      resenas.removeWhere((resenas) => resenas.idresena == resenaid);
      //plantas.removeWhere((plantas) => plantas[0] == idcoleccion);
    });
  }


  Future<String> obtenerUsuario(int iduser) async {
    Usuario usuario = Usuario(0, '', '', '', 0, true);
    List<dynamic> nombre = await usuario.getusuarionom(iduser);
    String username = nombre.isNotEmpty ? nombre[0][0].first.toString() : 'Nombre no encontrado';
    return username;
  }

  void loadResenasPlant() async {
    List<dynamic>? allResenas = await listaResenas.getresenaslist();
    if (allResenas != null) {
      setState(() {
        resenas = allResenas[0];
      });
    } else {
      print("No se encontraron reseñas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reseñas', style: TextStyle(fontSize: 23)),
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
              itemCount: resenas.length,
              itemBuilder: (context, index) {
                Resena currentResena = resenas[index];
                return Column(
                  children: [
                    ListTile(
                      title: ListBody(children: [
                        Text(
                          "ID Reseña : ${currentResena.idresena}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 20, 6),
                              fontSize: 18),
                        ),
                        FutureBuilder<String>(
                        future: obtenerUsuario(currentResena.iduser),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // Si el Future está en estado de carga, muestra un texto de carga.
                            return Text("Usuario: Cargando...",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 20, 6),
                                    fontSize: 18));
                          } else if (snapshot.hasError) {
                            // Si hubo un error al obtener el nombre del usuario, muestra un mensaje de error.
                            return Text("Usuario: Error al obtener el nombre",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 20, 6),
                                    fontSize: 18));
                          } else {
                            // Si el Future se ha completado, muestra el nombre del usuario.
                            return Text("Usuario: ${snapshot.data}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 20, 6),
                                    fontSize: 18));
                            }
                          },
                        ),
                        Text(
                          "Titulo: ${currentResena.titulo}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 20, 6),
                              fontSize: 18),
                        ),
                        Text(
                          "Detalle: ${currentResena.detalle}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 20, 6),
                              fontSize: 18),
                        ),
                      ]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Llamamos a la función eliminarResena al presionar el botón
                          eliminarResena(currentResena.idresena);
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
