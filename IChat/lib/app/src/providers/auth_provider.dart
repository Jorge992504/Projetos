import 'package:flutter/material.dart';
import 'package:ichat/app/core/keys/keys.dart';
import 'package:ichat/app/src/models/usuario_model.dart';
import 'package:ichat/app/src/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _token = '';
  String _email = '';
  UsuarioModel _usuarioModel = UsuarioModel();

  final LoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;

  AuthProvider({
    required LoginRepository loginRepository,
    required SharedPreferences sharedPreferences,
  }) : _loginRepository = loginRepository,
       _sharedPreferences = sharedPreferences {
    if (sharedPreferences.containsKey(Keys.token)) {
      _token = sharedPreferences.getString(Keys.token) ?? '';
      _isAuthenticated = _token.isNotEmpty;
      _email = sharedPreferences.getString(Keys.usuarioLogado) ?? '';
      _usuarioModel = sharedPreferences.getString(Keys.userModel) != null
          ? UsuarioModel.fromJson(sharedPreferences.getString(Keys.userModel)!)
          : UsuarioModel();
      notifyListeners();
    } else {
      _isAuthenticated = false;
      _token = '';
      _email = '';
      _usuarioModel = UsuarioModel();
      notifyListeners();
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final token = await _loginRepository.login(username, password);
      _token = token;
      _email = username;
      _isAuthenticated = true;
      await _sharedPreferences.setString(Keys.token, token);
      await _sharedPreferences.setString(Keys.usuarioLogado, username);
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      _token = '';
      await _sharedPreferences.remove(Keys.token);
      await _sharedPreferences.remove(Keys.usuarioLogado);
      notifyListeners();
    }
  }

  Future<bool> validateToken() async {
    if (_token.isEmpty) {
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
    try {
      final isValid = await _loginRepository.validateToken(_token);
      _isAuthenticated = isValid;
      if (!isValid) {
        _token = '';
        _email = '';
        await _sharedPreferences.remove(Keys.token);
        await _sharedPreferences.remove(Keys.usuarioLogado);
      }
      notifyListeners();
      return isValid;
    } catch (e) {
      _isAuthenticated = false;
      _token = '';
      _email = '';
      await _sharedPreferences.remove(Keys.token);
      await _sharedPreferences.remove(Keys.usuarioLogado);
      notifyListeners();
      return false;
    }
  }

  Future<void> atualizarUsuarioLogado() async {
    _usuarioModel = await _loginRepository.getUsuarioByEmail();
    await _sharedPreferences.setString(Keys.userModel, _usuarioModel.toJson());
    notifyListeners();
  }

  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  String get email => _email;
  UsuarioModel get usuarioModel => _usuarioModel;

  void logout() async {
    _isAuthenticated = false;
    _token = '';
    _email = '';
    _usuarioModel = UsuarioModel();
    await _sharedPreferences.remove(Keys.token);
    await _sharedPreferences.remove(Keys.userModel);
    await _sharedPreferences.remove(Keys.usuarioLogado);
    await _sharedPreferences.clear();
    notifyListeners();
  }
}
