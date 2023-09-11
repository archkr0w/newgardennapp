import 'package:newgarden/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'registro.dart';
//import '../config/rutas.dart' as route;

class PrimeraPag extends StatelessWidget {
  const PrimeraPag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                "New Garden",
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                height: 10,
              ),
              Text(""),
            ],
          ),
          Image.asset("assets/newgarden.png"),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(
                  buttonText: const Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onpressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => const LoginPage());
                    Navigator.push(context, route);
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => Registro());
                  Navigator.push(context, route);
                },
                child: const Text(
                  "Registrarse",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ],
      ),
    );
  }
}
