import '../modelos/modelo_planta.dart';
import '../modelos/modelo_resena.dart';
import '../modelos/modelo_coleccion.dart';
import 'controlador_eliminarres.dart';

class EliminarResModController{
  Future<List<dynamic>> getresenaslist() async {
    Resena resena = Resena(0, 0, 0, '', '', true);

    List listado = [];

    List<dynamic> resenas = await resena.getresena();

    listado.add(resenas);
    return listado;
  }

  Future<bool> dirigeEliminarResena(int idresena) async {
    Eliminar_Resena resena = Eliminar_Resena();
    resena.removeresena(idresena);
    return true;
  }
  
}
