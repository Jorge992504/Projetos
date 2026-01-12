// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:servicespro/core/keys/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/repository/login_repository.dart';

class AuthProvider extends ChangeNotifier {
  String _token = "";
  UsuarioModel _usuarioModel = UsuarioModel();
  bool _isAuth = false;

  final LoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;
  AuthProvider({
    required LoginRepository loginRepository,
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences,
       _loginRepository = loginRepository {
    if (_sharedPreferences.containsKey(Keys.token)) {
      _token = _sharedPreferences.getString(Keys.token) ?? "";
      _usuarioModel = UsuarioModel.fromJson(
        _sharedPreferences.getString(Keys.usuarioModel) ?? "",
      );
      _isAuth = _token.isNotEmpty;
      notifyListeners();
    } else {
      _token = "";
      _usuarioModel = UsuarioModel();
      _isAuth = false;
      notifyListeners();
    }
  }

  Future<void> salvarToken(String token) async {
    if (token.isNotEmpty) {
      _token = token;
      _isAuth = true;
      await _sharedPreferences.setString(Keys.token, token);
      notifyListeners();
    } else {
      _token = "";
      _isAuth = false;
      await _sharedPreferences.remove(Keys.token);
      await _sharedPreferences.remove(Keys.usuarioModel);
      log("Não foi possivel salvar o token");
      notifyListeners();
    }
  }

  Future<void> salvarDadosUsuario() async {
    UsuarioModel usuario = await _loginRepository.buscaDadosUsuario();
    if (usuario.email!.isNotEmpty) {
      _usuarioModel = usuario;
      await _sharedPreferences.setString(Keys.usuarioModel, usuario.toJson());
      notifyListeners();
    } else {
      await _sharedPreferences.remove(Keys.usuarioModel);
      log("Não foi possivel salvar os dados do usuário");
      notifyListeners();
    }
  }

  Future<bool> validarToken() async {
    bool validToken = await _loginRepository.validarToken();
    if (validToken) {
      _isAuth = true;
      notifyListeners();
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future<void> logout() async {
    _isAuth = false;
    _token = "";
    _usuarioModel = UsuarioModel();
    await _sharedPreferences.remove(Keys.token);
    await _sharedPreferences.remove(Keys.usuarioModel);
    await _sharedPreferences.clear();
    notifyListeners();
  }

  String get token => _token;
  bool get isAuth => _isAuth;
  UsuarioModel get usuarioModel => _usuarioModel;
}
