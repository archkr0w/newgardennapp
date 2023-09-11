//Modelos
import '../modelos/modelo_cuenta.dart';

class LoginController {
  //funcion para verificar si el correo esta en la DB
  Future<bool> validateEmail(
    String correo,
  ) async {
    Cuenta cuenta = Cuenta(0, '', correo, '', 0);
    return await cuenta.validateEmail(correo);
  }

//Funcion para el login     se le agrego un '?'
  Future<List<dynamic>?> login(String correo, String contrasena) async {
    Cuenta cuenta = Cuenta(0, '', correo, contrasena, 0);

    //autoregistro    se le agrego el '?'
    List<dynamic>? listado = await cuenta.login(
      correo,
      contrasena,
    );

    if (listado != null){    // El inicio de sesión fue exitoso, se encontró un usuario  
        return listado; 
    }
    else {        // El inicio de sesión falló, el usuario no fue encontrado.
        return null;
    }
  }
}
