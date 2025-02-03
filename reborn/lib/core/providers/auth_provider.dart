import 'package:flutter/material.dart';
import 'package:reborn/core/custom_dio/keys.dart';
import 'package:reborn/core/modelos/modelo_usuario.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _usuario = "";
  String _token = "";
  ModeloUsuario _model = ModeloUsuario.fromModeloUsuario();
  String email = '';

  final LoginRepository _authLogin;
  late SharedPreferences _sp;
  bool loading = false;

  AuthProvider(this._authLogin) {
    () async {
      _sp = await SharedPreferences.getInstance();
      //_sp.clear();
      if (_sp.containsKey(Keys.usuarioLogado)) {
        _usuario = _sp.getString(Keys.usuarioLogado) ?? "";
        _token = _sp.getString(Keys.token) ?? "";
        _model = await _authLogin.consultaUsuario();
        loading = true;
      }

      notifyListeners();
    }();
  }

  String get usuario => _usuario;
  bool get isAuth => _token.isNotEmpty;
  ModeloUsuario get model => _model;

  void atualizarUsuario(String user, String token) async {
    await _sp.setString(Keys.token, token);
    await _sp.setString(Keys.usuarioLogado, user);
    _usuario = user;
    _token = token;
    notifyListeners();
  }

  void sair() async {
    await _sp.clear();
    await _sp.remove(Keys.token);
    await _sp.remove(Keys.usuarioLogado);
    _usuario = "";
    _token = "";

    loading = false;
    notifyListeners();
  }

  void deletar() {}
}
