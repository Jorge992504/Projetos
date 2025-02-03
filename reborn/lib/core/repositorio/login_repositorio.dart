import 'package:reborn/core/modelos/modelo_login.dart';
import 'package:reborn/core/modelos/modelo_usuario.dart';

abstract class LoginRepository {
  Future<ModeloLogin> login(
    String usuario,
    String senha,
  );

  Future<ModeloUsuario> consultaUsuario();
}
