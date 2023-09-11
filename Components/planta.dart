import 'package:newgarden/vistas/detalle_planta.dart';
import 'package:newgarden/modelos/modelo_planta.dart';
import 'package:flutter/material.dart';

class MostrarPlanta extends StatelessWidget {
  final MostrarPlanta planta;

  const MostrarPlanta({Key? key, required this.planta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: GestureDetector(
        onTap: () {
          //Navigator.of(context).push(MaterialPageRoute(
          //builder: (context) => DetallePlanta(planta: planta)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  //imagen de la planta url
                  image: "assets/Image.png",
                  fit: BoxFit.cover,
                  height: 200,
                  width: 148,
                  placeholder: "assets/Image.png"),
            ),
            const SizedBox(
              height: 6,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20 / 4),
              child: Text(
                //planta._nombreController.text,
                'asd',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




/*
  ProductModel(
    productCategory: "Exterior",
    productDescription:
        "Son plantas sufruticosas, perennes de tallos de sección cuadrangular, generalmente muy foliosos en la parte inferior, con hojas de estrechamente lanceoladas a anchamente elípticas, enteras, dentadas o varias veces divididas, con pelos simples, ramificados y glandulíferos.",
    productId: "id2",
    productImages: [
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Single_lavender_flower02.jpg/1280px-Single_lavender_flower02.jpg",
      "https://images.hola.com/imagenes/decoracion/20210415187823/cultivar-lavanda-plantas-exterior-mc/0-940-990/cultivar-lavanda-3-a.jpg",
    ],
    productName: "Lavanda",
  ),

*/


