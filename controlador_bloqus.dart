import '../modelos/modelo_usuario.dart';
import '../modelos/modelo_resena.dart';

class BloquearUs {
  Future<bool> bloquearus(
    int id,
  ) async {
    Resena resena = Resena(id, 0, 0, '', '', true);
    await resena.removeresenauser(id);
    Usuario usuario = Usuario(id, '', '', '', 0, true);
    return await usuario.bloquearus(id);
  }

  Future<List<dynamic>> getusuario() async {
    Usuario usuario = Usuario(0, '', '', '', 0, true);
    List listado = [];
    listado.add(await usuario.getusuario());
    return listado;
  }
}
