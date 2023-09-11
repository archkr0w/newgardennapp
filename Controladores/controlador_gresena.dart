//Modelos
//Sin cantidad

import '../modelos/modelo_resena.dart';

class Anadir_Resena{
  
  Future<bool> setresena(int idp, int idu, String detalle, String titulo) async {
    
    Resena newresena = Resena(0, idp, idu, detalle, titulo, true);

    return await newresena.generaresena(idp, idu, detalle, titulo);
  }
}
