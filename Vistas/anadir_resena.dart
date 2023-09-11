import 'package:newgarden/modelos/modelo_usuario.dart';
import 'package:newgarden/modelos/modelo_planta.dart';

//import 'detalle_planta.dart';

import 'package:newgarden/controlador/controlador_gresena.dart';

import '../components/custom_button.dart';
import '../components/custom_appbar.dart';

import 'package:flutter/material.dart';

class ResenaPlantaScreen extends StatefulWidget {
  final Planta planta;
  final Usuario usuario;

  const ResenaPlantaScreen(
      {Key? key, required this.planta, required this.usuario})
      : super(key: key);

  @override
  _ResenaPlantaScreenState createState() => _ResenaPlantaScreenState();
}

class _ResenaPlantaScreenState extends State<ResenaPlantaScreen> {
  final _resenaController = TextEditingController();
  final _tituloController = TextEditingController();

  Anadir_Resena resena = Anadir_Resena();

  void agregarResena() async {
    String nuevaResena = _resenaController.text;
    String nuevotitulo = _tituloController.text;

    if (nuevaResena.isNotEmpty) {
      await resena.setresena(
          widget.planta.idplanta, widget.usuario.id, nuevaResena, nuevotitulo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Reseña', style: TextStyle(fontSize: 23)),
        centerTitle: true,
        flexibleSpace: buildGradientAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: "Titulo de reseña"),
              maxLength: 30,
              minLines: 1,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _resenaController,
              decoration: const InputDecoration(labelText: "Detalle de reseña"),
              maxLength: 250,
              minLines: 1,
              maxLines: 8,
            ),
            const SizedBox(height: 40),
            CustomButton(
                buttonText: const Text(
                  "Escribir reseña",
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                onpressed: () async {
                  agregarResena();
                  Navigator.of(context).pop();

                  //Navigator.of(context).push(MaterialPageRoute(
                  //    builder: (context) => DetallePlantaScreen(
                  //        planta: widget.planta, usuario: widget.usuario)));
                }),
          ],
        ),
      ),
    );
  }
}






/*
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Importar el paquete para acceder a ScrollController
import 'package:prueba_lol/controlador/controlador_gresena.dart';
import 'package:prueba_lol/modelos/modelo_resena.dart';
import 'package:prueba_lol/modelos/modelo_planta.dart';
import 'package:prueba_lol/controlador/controlador_verIplanta.dart';

class ResenaPlantaScreen extends StatefulWidget {
  int idplanta;
  int correo;

  ResenaPlantaScreen({Key? key, required this.idplanta, required this.correo})
      : super(key: key);

  @override
  _ResenaPlantaScreenState createState() => _ResenaPlantaScreenState();
}

class _ResenaPlantaScreenState extends State<ResenaPlantaScreen> {
  TextEditingController _resenaController = TextEditingController();
  TextEditingController _detalleController = TextEditingController();

  Anadir_Resena resena = Anadir_Resena();
  VerInfoPlanta listaresenas = VerInfoPlanta();

  List resenas = [];

  ScrollController _scrollController = ScrollController(); // Crear el controlador

  @override
  void initState() {
    super.initState();
    callresena();
  }

  void callresena() async {
    List<dynamic>? resenas =
        await listaresenas.getinfoplanta(widget.idplanta);
    if (resenas.isNotEmpty) {
      setState(() {
        resenas = resenas?[1];
      });
    } else {
      print("No se encontro la reseña papurri :v");
    }
  }

  void agregarResena() {
    String nuevaResena = _resenaController.text;
    String nuevotitulo = _detalleController.text;
    if (nuevaResena.isNotEmpty) {
      setState(() {
        resena.generaresena(
          widget.idplanta,
          widget.correo,
          nuevaResena,
          nuevotitulo,
        );
        _resenaController.clear();

        // Desplazar al usuario a la sección de la descripción después de agregar la reseña
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reseña de ${resenas[0].nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Asignar el controlador al ListView.builder
                itemCount: resenas[1].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(resenas[1][index].titulo),
                    subtitle: Text(resenas[1][index].detalle),
                  );
                },
              ),
            ),
            TextField(
              controller: _resenaController,
              decoration: InputDecoration(
                labelText: 'Escribir reseña',
                suffixIcon: IconButton(
                  onPressed: agregarResena,
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/