//Modelos
import '../modelos/modelo_planta.dart';

class ListadoPlanta {
  Future<List<dynamic>> getplantanombre(String nombre) async {
    Planta planta = Planta(0, nombre, '', '');
    //lista = { id , nombre }
    List listado = [];
    listado.add(await planta.getplantanombre(nombre));
    return listado;
  }
}
