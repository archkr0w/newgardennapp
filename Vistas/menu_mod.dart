import 'package:newgarden/components/custom_button.dart';
import 'package:newgarden/components/custom_appbar.dart';
import 'package:newgarden/modelos/modelo_cuenta.dart';
//import 'package:newgarden/modelos/modelo_moderador.dart';
import 'package:newgarden/vistas/primera_pag.dart';
import 'package:flutter/material.dart';
import 'package:newgarden/vistas/elim_resmod.dart';
import 'package:newgarden/vistas/bloquearus.dart';

class MenuMod extends StatefulWidget {
  final Cuenta moderador;

  const MenuMod({Key? key, required this.moderador}) : super(key: key);

  @override
  State<MenuMod> createState() => _MenuModState();
}

class _MenuModState extends State<MenuMod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: buildGradientAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Hola ${widget.moderador.nombre}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250.0,
                    height: 80.0,
                    child: CustomButton(
                      buttonText: const Text(
                        "Bloquear Usuario",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onpressed: () {
                        //logica del boton aaaaaa
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                BlockUserScreen(moderador: widget.moderador)));
                      },
                    ),
                  ),
                  const SizedBox(height: 90.0),
                  SizedBox(
                    width: 250.0,
                    height: 80.0,
                    child: CustomButton(
                      buttonText: const Text(
                        "Eliminar Reseñas",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onpressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EliminarResModScreen(
                                moderador: widget.moderador)));
                      },
                    ),
                    /*
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica para el botón 2
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 24.0),
                      ),
                      child: const Text('Eliminar Reseña'),
                    ),
                    */
                  ),
                  const SizedBox(height: 90.0),
                  SizedBox(
                    width: 250.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const PrimeraPag()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 24.0),
                      ),
                      child: const Text('Salir'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
