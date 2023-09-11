import '../modelos/modelo_usuario.dart';
import '../modelos/modelo_cuenta.dart';

class ObtenerUsu {
  Future<List<dynamic>> getdatausuario(String correo) async {
    Usuario user = Usuario(0, '', correo, '', 2, true);
    List datosU = await user.getdatausuario(correo);

    return datosU;
  }

  Future<List<dynamic>> getdatamod(String correo) async {
    Cuenta mod = Cuenta(0, '', correo, '', 2);
    List datosM = await mod.getdatamod(correo);

    return datosM;
  }
}
