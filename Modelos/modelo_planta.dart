import 'conexion_db.dart';

class Planta {
  late int idplanta;
  late String nombre;
  late String descripcion;
  late String imagen; // nuevooooo
  // this imagen
  //proposito de cambiarle el nombre a las plantas duplicadas
  Planta(this.idplanta, this.nombre, this.descripcion, this.imagen);

  Future<List> getplantanombre(String nombre) async {
    List<dynamic> newList = [];

    final connect = await conn();

    // Se convierte el nombre ingresado a minúsculas
    String nombreBusqueda = nombre.toLowerCase();

    // Construir el patrón de búsqueda
    String nnombre = "";
    for (int i = 0; i < nombreBusqueda.length; i++) {
      nnombre += nombreBusqueda[i] + "%";
    }

    var result = await connect.query(
      // el LOWER() convierte el nombre dentro de la base de datos a minúscula
      "SELECT id_planta, nombre, descripcion, imagen FROM planta WHERE LOWER(nombre) LIKE @nnom OR @nnom = '' ",
      substitutionValues: {"nnom": nnombre},
    );

    for (final row in result) {
      if (row.isNotEmpty) {
        // Avanza por filas (registros)
        Planta list = Planta(row[0], row[1], row[2], row[3]);
        newList.add(list);
      }
    }
    await connect.close();
    return newList;
  }
}
