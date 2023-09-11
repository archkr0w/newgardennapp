import 'package:flutter/material.dart';
import 'package:newgarden/modelos/modelo_planta.dart';
//import 'package:prueba_lol/modelos/modelo_coleccion.dart';
import 'package:newgarden/controlador/controlador_buscarp.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
//import 'package:prueba_lol/components/planta.dart';
//import 'package:prueba_lol/vistas/boton_lateral.dart';
import 'package:newgarden/vistas/detalle_planta.dart';

class MenuPrincipal extends StatefulWidget {
  //final int idU;
  //final String correo;
  final Usuario usuario;
  const MenuPrincipal({Key? key, required this.usuario}) : super(key: key);

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  final ListadoPlanta listaPlanta = ListadoPlanta();
  String isSeaching = "";
  List plantas = [];

  @override
  void initState() {
    super.initState();
    search(isSeaching);
  }

  void search(String isSeaching) async {
    List<dynamic>? allPlants = await listaPlanta.getplantanombre(isSeaching);
    if (allPlants.isNotEmpty) {
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
          Expanded(
            child: ListView.builder(
              itemCount: plantas.length,
              itemBuilder: (context, index) {
                Planta currentPlant = plantas[index];
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetallePlantaScreen(
                              planta: currentPlant, usuario: widget.usuario),
                        ));
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          //borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            image: currentPlant
                                .imagen, // Replace with the actual image URL
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                            placeholder: "assets/newgarden.png",
                          ),
                        ),
                        title: Text(
                          currentPlant.nombre,
                          style: const TextStyle(fontSize: 21),
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











