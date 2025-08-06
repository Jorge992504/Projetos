import 'package:faltou_nada/app/core/keys/keys.dart';
import 'package:faltou_nada/app/src/models/auth_model.dart';
import 'package:faltou_nada/app/src/models/user_model.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _usuario = '';
  String _token = '';
  UserModel _userModel = UserModel();

  final AuthRepository _loginRepository;
  final SharedPreferences _prefs;
  bool isLoading = false;

  AuthProvider({
    required AuthRepository loginRepository,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _loginRepository = loginRepository {
    if (_prefs.containsKey(Keys.token)) {
      _usuario = _prefs.getString(Keys.usuarioLogado) ?? '';
      _token = _prefs.getString(Keys.token) ?? '';
      notifyListeners();
    } else {
      _usuario = '';
      _token = '';
    }
  }

  Future<AuthModel> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    AuthModel authModel = await _loginRepository.login(email, password);
    _usuario = authModel.email;
    _token = authModel.token;

    await _prefs.setString(Keys.usuarioLogado, _usuario);
    await _prefs.setString(Keys.token, _token);
    return authModel;
  }

  String get usuario => _usuario;
  bool get isAuthenticated => _usuario.isNotEmpty;
  String get token => _token;
  UserModel get userModel => _userModel;

  Future<void> autualizarUsearioSP() async {
    _userModel = await _loginRepository.buscarUsuario();
    await _prefs.setString(Keys.userModel, _userModel.toJson());
    notifyListeners();
  }

  void logout() async {
    _usuario = '';
    _token = '';
    _userModel = UserModel();
    await _prefs.remove(Keys.usuarioLogado);
    await _prefs.remove(Keys.token);
    await _prefs.clear();
    isLoading = false;
    notifyListeners();
  }
}
