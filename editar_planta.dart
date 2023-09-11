//import 'package:newgarden/controlador/controlador_coleccion.dart';
//import '../modelos/modelo_coleccion.dart';
import '../components/custom_button.dart';
import '../components/custom_appbar.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
import 'package:flutter/material.dart';
import 'package:newgarden/controlador/controlador_editarplanta.dart';
import 'package:newgarden/vistas/mi_coleccion.dart';


class EditarPlantaScreen extends StatefulWidget {
  final Usuario usuario;
  final int idcol;

  const EditarPlantaScreen({Key? key,  required this.usuario, required this.idcol})
      : super(key: key);

  @override
  _EditarPlantaScreenState createState() => _EditarPlantaScreenState();
}

class _EditarPlantaScreenState extends State<EditarPlantaScreen> {
  final _aliasController = TextEditingController();
  final _descripcionController = TextEditingController();

//idusr, idcoleccion, alias, descripcion
  Editplanta editarplanta = Editplanta();

  void editplanta(
      int idcoleccion, String nuevoalias, String nuevodescripcion) async {
    if (nuevoalias.isNotEmpty || nuevodescripcion.isNotEmpty) {
      await editarplanta.setdatos(idcoleccion, nuevoalias, nuevodescripcion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar planta de la coleccion',
            style: TextStyle(fontSize: 23)),
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
              controller: _aliasController,
              decoration:
                  const InputDecoration(labelText: "Alias de la planta"),
              maxLength: 30,
              minLines: 1,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _descripcionController,
              decoration:
                  const InputDecoration(labelText: "Descripcion de la planta"),
              maxLength: 250,
              minLines: 1,
              maxLines: 8,
            ),
            const SizedBox(height: 40),
            CustomButton(
                buttonText: const Text(
                  "Aceptar",
                  style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                onpressed: () async {
                  editplanta(widget.idcol, _aliasController.text,
                      _descripcionController.text);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
