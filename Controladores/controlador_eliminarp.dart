//Eliminar plantas de la reseñaaaaa
import '../modelos/modelo_coleccion.dart';

class Eliminar_Planta {
  Future<bool> removeplanta(int idusr, int idp, String nombre) async {
    Coleccion coleccion = Coleccion(idp, idusr, 0, '', '');

    return await coleccion.removeplanta(idusr, idp);
  }
}
