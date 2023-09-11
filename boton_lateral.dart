//import 'package:prueba_lol/components/custom_button.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:newgarden/modelos/modelo_usuario.dart';
import 'package:newgarden/vistas/menu_principal.dart';
import 'package:newgarden/vistas/primera_pag.dart';
import 'package:newgarden/vistas/mi_coleccion.dart';
import 'package:flutter/material.dart';

//import '../config/rutas.dart' as route;

//import '../categories/categories_view_all.dart';

class BotonLateral extends StatefulWidget {
  final Usuario usuario;

  const BotonLateral({Key? key, required this.usuario}) : super(key: key);

  @override
  State<BotonLateral> createState() => _BotonLateralState();
}

class _BotonLateralState extends State<BotonLateral> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hola ${widget.usuario.nombre}",
                style: const TextStyle(
                    color: Color.fromARGB(239, 30, 30, 30), fontSize: 25),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Menú",
                    style: TextStyle(
                        color: Color.fromARGB(149, 0, 0, 0), fontSize: 20)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MiColeccion(usuario: widget.usuario),
                    ),
                  );
                },
                child: const Text("Mi colección",
                    style: TextStyle(
                        color: Color.fromARGB(150, 0, 0, 0), fontSize: 20)),
              ),
              TextButton(
                onPressed: () async {
                  //logOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const PrimeraPag()));
                },
                child: const Text("Salir",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('New Garden', style: TextStyle(fontSize: 23)),
        centerTitle: true,
        flexibleSpace: buildGradientAppBar(),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Image.asset("assets/MenuBarW.png"),
        ),
      ),
      key: _scaffoldKey,
      body: MenuPrincipal(usuario: widget.usuario),
    );
  }
}
