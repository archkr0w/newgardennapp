import 'package:flutter/material.dart';
import 'package:newgarden/vistas/primera_pag.dart';

/*
Usuario:
+vista general LISTOO
+vista detalle planta (planta + reseñas) LISTOO
+campo reseñas LISTOO
+vista mi coleccion de plantas LISTOO
-editar coleccion

Moderador:
+vista general
-vista eliminar reseña usuario
-vista eliminar reseña moderador
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrimeraPag(), // Pantalla principal de tu aplicación
      //home: LoginPage(),
    );
  }
}
