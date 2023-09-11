import 'conexion_db.dart';

class Resena {
  late int idresena;
  late int iduser;
  late int idplanta;
  late String titulo;
  late String detalle;
  late bool estado;

  //late String nombre;

  Resena(this.idresena, this.iduser, this.idplanta, this.titulo, this.detalle,
      this.estado);

  Future<bool> generaresena(
      int idplanta, int iduser, String detalle, String titulo) async {
    final connect = await conn();
    await connect.query(
        "INSERT INTO resena (id_planta, id_user, detalle, estado, titulo) VALUES (@idplanta, @iduser, @detalle, @estado, @titulo)",
        substitutionValues: {
          "idplanta": idplanta,
          "iduser": iduser,
          "detalle": detalle,
          "estado": true,
          "titulo": titulo
        });

    await connect.close();
    return true;
  }

  Future<List> getresena() async {
    List<Resena> newList = [];

    final connect = await conn();
    var result = await connect.query(
        "SELECT id_resena, id_user, id_planta,detalle, estado, titulo FROM resena WHERE estado = 'true' ORDER BY id_resena DESC");
    for (final row in result) {
      if (row.isNotEmpty) {
        //avanza por filas (registros)
        Resena list = Resena(row[0], row[1], row[2], row[5], row[3], row[4]);
        newList.add(list);
      }
    }

    await connect.close();

    return newList;
  }

  Future<bool> removeresena(int idresena) async {
    final connect = await conn();
    await connect.query(
      "UPDATE resena SET estado = false WHERE id_resena = @id_resena",
      substitutionValues: {
        'id_resena': idresena,
      },
    );
    await connect.close();
    return true;
  }

  Future<bool> removeresenauser(int iduser) async {
    final connect = await conn();
    await connect.query(
      "UPDATE resena SET estado = false WHERE id_user = @iduser",
      substitutionValues: {
        'iduser': iduser,
      },
    );
    await connect.close();
    return true;
  }

  Future<List> getresenaplanta(int idp) async {
    List<dynamic> newList = [];

    final connect = await conn();
    var resenas = await connect.query(
        "SELECT resena.id_resena, resena.id_user, resena.detalle, resena.titulo, usuario.nombre FROM resena JOIN usuario ON resena.id_user = usuario.id WHERE resena.id_planta = @idplanta AND resena.estado = true",
        substitutionValues: {"idplanta": idp});

    for (final row in resenas) {
      if (row.isNotEmpty) {
        //avanza por filas (registros)
        List list = [row[0], row[1], row[2], row[3], row[4]];
        newList.add(list);
      }
    }
    await connect.close();
    return newList;
  }
}



/*
consulta original getresenapla

"SELECT re.id_resena, re.id_user, us.nombre, re.detalle, re.titulo FROM resena re, usuario us WHERE re.id_planta = @idplanta AND re.id_user = us.id_user AND re.estado = true"

*/
