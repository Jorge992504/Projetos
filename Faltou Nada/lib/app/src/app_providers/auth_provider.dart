import 'package:faltou_nada/app/core/keys/keys.dart';
import 'package:faltou_nada/app/src/models/auth_model.dart';
import 'package:faltou_nada/app/src/models/user_model.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _email = '';
  String _token = '';
  UserModel _userModel = UserModel();

  final AuthRepository _loginRepository;
  final SharedPreferences _prefs;
  // bool isLoading = false;

  AuthProvider({
    required AuthRepository loginRepository,
    required SharedPreferences prefs,
  }) : _prefs = prefs,
       _loginRepository = loginRepository {
    if (_prefs.containsKey(Keys.token)) {
      _email = _prefs.getString(Keys.usuarioLogado) ?? '';
      _token = _prefs.getString(Keys.token) ?? '';
      final userJson = _prefs.getString(Keys.userModel);
      _userModel = userJson != null
          ? UserModel.fromJson(userJson)
          : UserModel();
      notifyListeners();
    } else {
      _email = '';
      _token = '';
      _userModel = UserModel();
    }
  }

  Future<AuthModel> login(AuthModel authModel) async {
    // isLoading = true;

    _token = authModel.token;

    await _prefs.setString(Keys.usuarioLogado, _email);
    await _prefs.setString(Keys.token, _token);
    notifyListeners();
    return authModel;
  }

  Future<bool> atualizar(String token, String email) async {
    if (token.isNotEmpty) {
      _token = token;

      await _prefs.setString(Keys.usuarioLogado, email);
      await _prefs.setString(Keys.token, _token);

      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<void> autualizarUsearioSP() async {
    _userModel = await _loginRepository.buscarUsuario();
    await _prefs.setString(Keys.userModel, _userModel.toJson());
    notifyListeners();
  }

  String get usuario => _email;
  bool get isAuthenticated => _token.isNotEmpty;
  String get token => _token;
  UserModel get userModel => _userModel;

  void logout() async {
    _email = '';
    _token = '';
    _userModel = UserModel();
    await _prefs.remove(Keys.usuarioLogado);
    await _prefs.remove(Keys.token);
    await _prefs.clear();
    // isLoading = false;
    notifyListeners();
  }
}
