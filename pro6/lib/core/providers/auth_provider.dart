import 'package:activovo/core/models/usuario.dart';
import 'package:activovo/dto/keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  List<Usuario> _usuarios = [];
  Usuario? _usuarioLogado;

  AuthProvider() {
    //salvar os dados do login
    () async {
      _prefs = await SharedPreferences.getInstance();
      if (_prefs.containsKey(Keys.usuarios)) {
        List<String>? usuarios = _prefs.getStringList(Keys.usuarios);
        _usuarios = usuarios!.map((e) => Usuario.fromJson(e)).toList();
      }
      if (_prefs.containsKey(Keys.usuarioLogado)) {
        String? user = _prefs.getString(Keys.usuarioLogado);
        _usuarioLogado = Usuario.fromJson(user!);
      }
      notifyListeners();
    }();
  }

  Usuario? get usuario => _usuarioLogado;
  bool get isAuth => _usuarioLogado != null;

  Future<bool> cadastrarUsuario(Usuario usuario) async {
    if (usuaExiste(usuario)) {
      return false;
    }
    _usuarios.add(usuario);
    List<String> usuarios = _usuarios
        .map((e) => e.toJson())
        .toList(); //convertir lista objeto para lista string
    return await _prefs.setStringList(Keys.usuarios, usuarios); //gravar
  }

  bool usuaExiste(Usuario usuario) {
    // saber se o usuario ja existe
    for (final user in _usuarios) {
      if (usuario.usua == user.usua) {
        return true;
      }
    }
    return false;
  }

  void sair() {
    _prefs.remove(Keys.usuarioLogado);
  }
}
