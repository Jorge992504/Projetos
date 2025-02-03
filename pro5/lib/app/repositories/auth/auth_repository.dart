import 'package:delivery/app/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> registerUsuarios(String email, String nome, String senha);
  Future<AuthModel> login(String email, String senha);
}
