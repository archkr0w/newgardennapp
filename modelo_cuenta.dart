import 'conexion_db.dart';

class Cuenta {
  late int id;
  late String nombre;
  late String correo;
  late String password;
  late int tipo;

  Cuenta(this.id, this.nombre, this.correo, this.password, this.tipo);

  Future<bool> validateEmail(String correo) async {
    final connection = await conn();
    final result = await connection.query(
        'SELECT * FROM cuenta WHERE correo = @correo',
        substitutionValues: {'correo': correo});
    await connection.close();
    if (result.isEmpty) {
      print('El Email no ha sido encontrado!');
      return false;
    } else {
      print('El Email ha sido encontrado');
      return true;
    }
  }

  // se agrego el ?
  Future<List<dynamic>?> login(String correo, String password) async {
    final connection = await conn();
    final result = await connection.query(
        'SELECT * FROM cuenta WHERE correo = @correo AND password = @password',
        substitutionValues: {'correo': correo, 'password': password});

    await connection.close();

    if (result.isEmpty) {
      print('Usuario no encontrado');
      return null; // se envia null
    } else {
      print('Usuario encontrado');
      return result;
    }
  }

  Future<List<dynamic>> getdatamod(String correo) async {
    List<dynamic> newList = [];

    final connection = await conn();
    var result = await connection.query(
        'SELECT * FROM cuenta WHERE correo = @correo AND correo in (SELECT correo FROM moderador)',
        substitutionValues: {"correo": correo});
    for (final row in result) {
      if (row.isNotEmpty) {
        Cuenta usuario = Cuenta(row[0], row[1], row[2], row[3], row[4]);
        newList.add(usuario);
      }
    }
    await connection.close();
    return newList;
  }
}
