import 'conexion_db.dart';
import 'modelo_planta.dart';

class Coleccion {
  late int idcoleccion;
  late int idusuario;
  late int idplanta;
  late String alias;
  late String descripcion;

  Coleccion(
      this.idcoleccion, idusuario, this.idplanta, this.alias, this.descripcion);

//Obtenemos la coleccion de plantas
  Future<List> getcoleccion(String nombre, int iduser) async {
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
      "SELECT c.id_coleccion, c.id_usuario, c.id_planta, c.alias, c.descripcion, p.id_planta, p.nombre, p.descripcion, p.imagen FROM Coleccion c, planta p WHERE (c.id_planta = p.id_planta) AND (c.id_usuario = @iduser) AND (LOWER(nombre) LIKE @nnom OR @nnom = '' )",
      substitutionValues: {"iduser": iduser, "nnom": nnombre},
    );

    for (final row in result) {
      if (row.isNotEmpty) {
        // Avanza por filas (registros)
        //Coleccion coleccion = Coleccion(row[0], row[1], row[2], row[3], row[4]);
        Planta planta = Planta(row[5], row[6], row[7], row[8]);
        List todo_s_e_p_a_r_a_d_o = [row[0], row[1], planta, row[3], row[4]];
        //newList.add(coleccion);
        newList.add(todo_s_e_p_a_r_a_d_o);
        //newList.add(planta);
        //newList.add(coleccion);
      }
    }
    await connect.close();
    return newList;
  }

  Future<bool> addplanta(
    int idusr,
    Planta idp,
  ) async {
    final connect = await conn();
    await connect.query(
      "INSERT INTO coleccion (id_usuario, id_planta, alias , descripcion) VALUES(@id_usuario , @id_planta , '' , '')",
      substitutionValues: {
        'id_usuario': idusr,
        'id_planta': idp.idplanta,
      },
    );
    await connect.close();
    return true;
  }

  Future<bool> removeplanta(int idusr, int idcoleccion) async {
    final connect = await conn();
    await connect.query(
      "DELETE FROM coleccion WHERE id_usuario =  @id_usr AND id_coleccion = @idcoleccion",
      substitutionValues: {
        'id_usr': idusr,
        'idcoleccion': idcoleccion,
      },
    );
    await connect.close();
    return true;
  }

  Future<bool> editplanta(
    int idColeccion,
    String alias,
    String descripcion,
  ) async {
    final connect = await conn();
    await connect.query(
      "UPDATE coleccion SET alias = @alias , descripcion =  @descripcion  WHERE id_coleccion = @idColeccion",
      substitutionValues: {
        'idColeccion': idColeccion,
        'alias': alias,
        'descripcion': descripcion
      },
    );
    print("mando la cosa");
    await connect.close();
    return true;
  }
}
