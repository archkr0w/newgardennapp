import 'package:flutter/material.dart';
import 'package:newgarden/controlador/controlador_coleccion.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:newgarden/vistas/detalle_planta.dart';
import 'package:newgarden/vistas/editar_planta.dart';

class MiColeccion extends StatefulWidget {

  final Usuario usuario;

  const MiColeccion({Key? key, required this.usuario}) : super(key: key);

  @override
  State<MiColeccion> createState() => _MiColeccionState();
}

class _MiColeccionState extends State<MiColeccion> {
  final ColeccionController coleccionPlanta = ColeccionController();
  String isSeaching = "";
  List plantas = [];

  @override
  void initState() {
    super.initState();
    search(isSeaching);
  }

  void eliminarPlanta(int idcoleccion, int iduser) async {
    setState(() {
      plantas.removeWhere((plantas) => plantas[0] == idcoleccion);
      coleccionPlanta.removeplanta(iduser, idcoleccion);
      
    });
  }

  void search(String isSeaching) async {
    List<dynamic>? allPlants =
        await coleccionPlanta.obtenercoleccion(isSeaching, widget.usuario.id);
    if (allPlants != null) {
      setState(() {
        plantas = allPlants[0];
      });
    } else {
      print("No se encontraron plantas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi colección', style: TextStyle(fontSize: 23)),
        centerTitle: true,
        flexibleSpace: buildGradientAppBar(),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            //padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 174, 170, 170),
                  blurRadius: 30,
                  offset: Offset(0, 10)),
            ]),

            child: TextFormField(
              // Inicio barrita buscador
              onChanged: (isSeaching) => search(isSeaching),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  hintText: "Buscar planta",
                  prefixIcon: Image.asset("assets/search.png"),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1))),
            ), // Fin barrita buscador
          ),
          const Divider(),
          Expanded(
            child: plantas.isEmpty?
              const Center(
                child: Text(
                  "No existen plantas.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 20, 6),
                  ),
                ),
              )
              :ListView.builder(
              itemCount: plantas.length,
              itemBuilder: (context, index) {
                final List currentPlant = plantas[index];
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetallePlantaScreen(
                              planta: currentPlant[2], usuario: widget.usuario),
                        ));
                      },
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        leading: ClipRRect(
                          //borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            image: currentPlant[2]
                                .imagen, // Replace with the actual image URL
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                            placeholder: "assets/newgarden.png",
                          ),
                        ),
                        //a?b:c
                        title: Text(
                          //if alias != null
                          currentPlant[2].nombre + ((currentPlant[3]!="")?(" (${currentPlant[3]})"):("")) ,
                          style: const TextStyle(fontSize: 21),
                        ),
                        subtitle: Text(
                          currentPlant[4]!=""?currentPlant[4]:"(Sin descripción)",

                          style: const TextStyle(fontSize: 15),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditarPlantaScreen(usuario: widget.usuario,
                                        idcol: currentPlant[
                                            0]))).then((value) {
                                              setState(() {
                                                search("");
                                              });
                                            }); // Llamamos a la función eliminarResena al presionar el botón
                                //editplanta([index][0]);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons
                                  .delete), // Icono de editar, puedes cambiarlo según tus necesidades
                              onPressed: () {
                                eliminarPlanta(
                                    currentPlant[0], widget.usuario.id);
                                // Implementa la lógica para editar la planta aquí
                                // Puedes abrir un diálogo o navegar a una nueva pantalla para editar la planta
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(), // Agrega un separador después de cada elemento
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
