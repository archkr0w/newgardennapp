import 'conexion_db.dart';
import 'modelo_cuenta.dart';

class Moderador extends Cuenta {
  Moderador(int id, String nombre, String email, String password, int tipo)
      : super(id, nombre, email, password, tipo);

  // Bloquea un usuario por su ID
  Future<bool> _bloquearUsuario(int id) async {
    final connection = await conn();
    await connection.query(
        //falta antes bloquear todas las reseñas antes
        'UPDATE usuario SET estado = false WHERE id_us = @id',
        substitutionValues: {'id_us': id});
    await connection.close();
    return true;
  }

  // Eliminar una reseña resena
  Future<bool> _eliminarResena(int id_res) async {
    final connection = await conn();
    await connection.query(
        'UPDATE resena SET estado = false WHERE id_resena = @id',
        substitutionValues: {'id': id_res});
    await connection.close();
    return true;
  }
}
