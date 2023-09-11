//Modelos
import '../modelos/modelo_cuenta.dart';
import '../modelos/modelo_usuario.dart';

class Registrocontroller {
  //funcion para verificar si el correo esta en la DB
  Future<bool> validateEmail(String correo) async {
    Cuenta cuenta = Cuenta(0, '', correo, '', 0);
    return await cuenta.validateEmail(correo);
  }

//Funcion para el registro
  Future<bool> registro(String correo, String nombre, String contrasena) async {
    Usuario usuario = Usuario(0, correo, nombre, contrasena, 0, true);

    //autoregistro
    return await usuario.autoregister(
      nombre,
      correo,
      contrasena,
    );
  }
}
