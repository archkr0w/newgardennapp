import '../modelos/modelo_coleccion.dart';

class Editplanta {
  Future<bool> setdatos(
      int idcoleccion, String alias, String descripcion) async {
    Coleccion coleccion = Coleccion(0, 0, 0, '', '');
    //lista = { id , nombre }
    //coleccion.indexWhere((plantas) => plantas[0] == idcoleccion);
    return await coleccion.editplanta(idcoleccion, alias, descripcion);
  }
// UPDATE public.coleccion
//	SET descripcion=?, alias=?
//	WHERE id_coleccion=?;
}
