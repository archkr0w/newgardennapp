import 'conexion_db.dart';
import 'modelo_cuenta.dart';

class Usuario extends Cuenta {
  late bool estado;

  Usuario(int id, String nombre, String correo, String password, int tipo,
      this.estado)
      : super(id, nombre, correo, password, tipo);

  //Mandamos us to db
  Future<bool> autoregister(
      String nombre, String correo, String password) async {
    final connection = await conn();
    await connection.query(
        'INSERT INTO  usuario (nombre, correo, password, tipo_user, estado) VALUES(@nombre, @correo, @password, @tipo_user, @estado)',
        substitutionValues: {
          'nombre': nombre,
          'correo': correo,
          'password': password,
          'tipo_user': 2,
          'estado': true
        });

    await connection.close();
    return true;
  }

  // Obtiene usuarios bloqueados
  Future<List<dynamic>> getusuario() async {
    List<dynamic> newList = [];
    final connect = await conn();
    var result = await connect
        .query("SELECT * FROM usuario WHERE estado = true ORDER BY nombre ASC");
    for (final row in result) {
      if (row.isNotEmpty) {
        //avanza por filas (registros)
        Usuario usuario =
            Usuario(row[0], row[1], row[2], row[3], row[4], row[5]);
        newList.add(usuario);
      }
    }
    await connect.close();

    return newList;
  }

  Future<List> getusuarionom(int iduser) async {
    List<dynamic> newList = [];
    final connect = await conn();
    var usuarios = await connect.query(
        "SELECT nombre FROM usuario WHERE id = @iduser",
        substitutionValues: {"iduser": iduser});
    newList.add(usuarios);
    await connect.close();
    return newList;
  }

  Future<bool> bloquearus(int id) async {
    final connection = await conn();
    //falta antes bloquear todas las reseñas antes
    await connection.query('UPDATE usuario SET estado = false WHERE id = @id',
        substitutionValues: {'id': id});
    await connection.close();
    return true;
  }

  Future<List<dynamic>> getdatausuario(String correo) async {
    List<dynamic> newList = [];

    final connection = await conn();
    var result = await connection.query(
        'SELECT * FROM usuario WHERE correo = @correo ',
        substitutionValues: {"correo": correo});
    for (final row in result) {
      if (row.isNotEmpty) {
        Usuario usuario =
            Usuario(row[0], row[1], row[2], row[3], row[4], row[5]);
        newList.add(usuario);
      }
    }
    await connection.close();
    return newList;
  }
}
