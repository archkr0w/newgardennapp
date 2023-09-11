//Modelos
import '../modelos/modelo_planta.dart';
import '../modelos/modelo_resena.dart';
import '../modelos/modelo_coleccion.dart';
import 'controlador_eliminarres.dart';

class VerInfoPlanta {
  set id(int id) {}

  Future<List<dynamic>> getinfoplanta(int id) async {
    Resena resena = Resena(0, 0, id, '', '', true);

    List listado = [];

    List<dynamic> resenas = await resena.getresenaplanta(id);

    listado.add(resenas);
    return listado;
  }

  Future<bool> dirigeEliminarResena(int idresena) async {
    Eliminar_Resena resena = Eliminar_Resena();
    resena.removeresena(idresena);

    return true;
  }

  Future<bool> anadirplanta(Planta planta, int iduser) async {
    return await Coleccion(0, 0, 0, '', '').addplanta(iduser, planta);
  }
}
