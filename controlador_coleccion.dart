//Importamos modelos
import '../modelos/modelo_coleccion.dart';

//Funcion para tener la coleccion de plantas
class ColeccionController {
  Future<List<dynamic>?> obtenercoleccion(String nombre, int idus) async {
    Coleccion coleccion = Coleccion(0, 0, 0, '', '');
    //lista = { id , nombre }
    List listado = [];
    listado.add(await coleccion.getcoleccion(nombre, idus));
    return listado;
  }

  Future<bool> removeplanta(int iduser, int idcoleccion) async {
    Coleccion coleccion = Coleccion(0, 0, 0, '', '');
    return await coleccion.removeplanta(iduser, idcoleccion);
  }
}
/*
  Future<bool> removeplanta(
    int idusr,
    int idp,
  ) async {
    final connect = await conn();
    await connect.query(
      "DELETE FROM coleccion WHERE id_user =  @id_usr AND id_planta = @id_planta)",
      substitutionValues: {
        'id_usuario': idusr,
        'id_planta': idplanta,
        'alias': alias,
        'descripcion': descripcion
      },
    );
    await connect.close();
    return true;
  }

//Modelos
//Sin cantidad


import '../modelos/modelo_coleccion.dart';

class Anadir_Resena{
  
  Future<bool> (int idp, int idu, String detalle, String titulo) async {
    
    Resena newresena = Resena(0, idp, idu, detalle, titulo, true);

    return await newresena.generaresena(idp, idu, detalle, titulo);
  }
}



*/