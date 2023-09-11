//import 'package:carousel_slider/carousel_slider.dart';
import 'package:newgarden/modelos/modelo_planta.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
import 'anadir_resena.dart';
import 'package:newgarden/controlador/controlador_verIplanta.dart';
//import 'package:newgarden/vistas/boton_lateral.dart';

//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:flutter/material.dart';
//import 'package:prueba_lol/modelos/modelo_planta.dart';

class DetallePlantaScreen extends StatefulWidget {
  final Planta planta;
  final Usuario usuario;

  const DetallePlantaScreen(
      {Key? key, required this.planta, required this.usuario})
      : super(key: key);

  @override
  State<DetallePlantaScreen> createState() => _DetallePlantaState();
}

class _DetallePlantaState extends State<DetallePlantaScreen> {
  final VerInfoPlanta listaResenas = VerInfoPlanta();
  List resenas = [];
  late int idp;

  @override
  void initState() {
    super.initState();
    idp = widget.planta.idplanta;
    loadResenasPlant(idp); // Accede al miembro 'widget' en initState
  }

  void eliminarResena(int resenaId) async {
    setState(() {
      listaResenas.dirigeEliminarResena(resenaId);
      resenas.removeWhere((resena) => resena[0] == resenaId);
    });
  }

  void agregarPlanta() async {
    // Aquí debes implementar la lógica para agregar la planta usando el controlador
    // Reemplaza 'tu_logica_de_agregar_planta' con la lógica real que tengas en tu controlador.
    bool plantaAgregada =
        await listaResenas.anadirplanta(widget.planta, widget.usuario.id);
    if (plantaAgregada) {
      // Aquí puedes mostrar una notificación, un diálogo o realizar alguna acción si la planta fue agregada exitosamente.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Planta agregada exitosamente')),
      );
    } else {
      // Aquí puedes mostrar una notificación o un diálogo indicando que hubo un error al agregar la planta.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar la planta')),
      );
    }
  }

  void loadResenasPlant(int idp) async {
    List<dynamic>? allResenas = await listaResenas.getinfoplanta(idp);
    if (allResenas.isNotEmpty) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                agregarPlanta();
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
              child: const Text("Añadir Planta"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => ResenaPlantaScreen(
                            planta: widget.planta, usuario: widget.usuario)))
                    .then((value) {
                  setState(() {
                    loadResenasPlant(idp);
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
              child: const Text("Añadir Reseña"),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                //aqui abajo debería ir una imagen url
                image: widget
                    .planta.imagen, // Reemplazar con la URL real de la imagen
                fit: BoxFit.cover,
                height: 180,
                width: 210,
                placeholder: "assets/newgarden.png",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.planta.nombre,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Divider(),
                const Text(
                  "Descripción",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.planta.descripcion,
                  //maxLines: descTextShowFlag ? 8 : 8,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102)),
                ),
                const Divider(),
                const Text(
                  "Reseñas",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Ajusta el espacio entre los detalles y la lista
          Expanded(
            child: resenas.isEmpty
                ? const Center(
                    child: Text(
                      "No hay reseñas para esta planta.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 20, 6),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: resenas.length,
                    itemBuilder: (context, index) {
                      final currentResena = resenas[index];
                      if (resenas[index][1] == widget.usuario.id) {
                        return Column(
                          children: [
                            ListTile(
                              title: ListBody(children: [
                                Text(
                                  currentResena[3],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 20, 6),
                                      fontSize: 18),
                                ),
                                Text(currentResena[4],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 51, 51, 51),
                                        fontSize: 16)),
                                Text(currentResena[2],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 59, 59, 59),
                                        fontSize: 15)),
                              ]),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Llamamos a la función eliminarResena al presionar el botón
                                  eliminarResena(resenas[index][0]);
                                },
                              ),
                            ),
                            Divider(), // Agregar un Divider entre los elementos de la lista
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            ListTile(
                              title: ListBody(children: [
                                Text(
                                  currentResena[3],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 20, 6),
                                      fontSize: 18),
                                ),
                                Text(currentResena[4],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 51, 51, 51),
                                        fontSize: 16)),
                                Text(currentResena[2],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 59, 59, 59),
                                        fontSize: 15)),
                              ]),
                            ),
                            Divider(), // Agregar un Divider entre los elementos de la lista
                          ],
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}














/*

  cuando termina el AppBar

      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Lógica para el primer botón
            },
            child: const Text("Añadir a Mi Colección"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResenaPlantaScreen(planta: widget.planta, correo: widget.correo)));
              // Lógica para el segundo botón
            },
            child: const Text("Añadir reseña a la planta"),
          ),
        ],
      ),

    y empieza el body column

    */









 /*

    cuando termina el AppBar

      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: const Text("Añadir a Mi Colección"),
                  ),
                  
                ),
              )
            ],
          ),
        ),
      ),


      y empieza el bottomNavigationBa  row
*/






/*
      

  donde termina el column


      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: resenas[1].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(resenas[1][index].titulo),
                    subtitle: Text(resenas[1][index].detalle),
                  );
                },
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Escribir reseña',
                suffixIcon: IconButton(
                onPressed: () => agregarResena(),
                Navigator.of(context).pop();
                icon: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      )

  y donde termina el scaffold



      */