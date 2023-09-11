//Sin cantidad
import '../modelos/modelo_resena.dart';


class Eliminar_Resena{
  Future<bool> removeresena(int idresena) async {
    Resena resena = Resena(idresena, 0, 0 , '' , '', false);


    
    return await resena.removeresena(idresena);
    
  }
}
