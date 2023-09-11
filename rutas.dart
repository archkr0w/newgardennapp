import 'package:newgarden/vistas/primera_pag.dart';
import 'package:newgarden/vistas/login.dart';
import 'package:newgarden/vistas/registro.dart';
import 'package:newgarden/vistas/menu_principal.dart';
import 'package:flutter/material.dart';

// variable for our route names
const String primera_pag = 'primera_pag';
const String loginPage = 'login';
const String menu_principal = 'menu_principal';
const String registro = 'registro';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case primera_pag:
      return MaterialPageRoute(builder: (context) => PrimeraPag());

    case loginPage:
      return MaterialPageRoute(builder: (context) => LoginPage());

    /*
    case menu_principal:
      return MaterialPageRoute(builder: (context) => const Menuprincipal());
    */
    case registro:
      return MaterialPageRoute(builder: (context) => Registro());
    default:
      throw ('la ruta no existe');
  }
}
