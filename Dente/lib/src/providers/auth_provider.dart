import 'package:dente/core/keys/keys.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token = "";
  String _usuarioLogado = "";
  EmpresaModel _empresaModel = EmpresaModel();
  bool _isAuth = false;

  final LoginRepository _loginRepository;
  final SharedPreferences _prefs;

  AuthProvider({
    required LoginRepository loginRepository,
    required SharedPreferences prefs,
  }) : _prefs = prefs,
       _loginRepository = loginRepository {
    if (_prefs.containsKey(Keys.token)) {
      _token = _prefs.getString(Keys.token) ?? "";
      _usuarioLogado = _prefs.getString(Keys.usuarioLogado) ?? "";
      final empresaJson = _prefs.getString(Keys.empresaModel);
      _empresaModel = empresaJson != null
          ? EmpresaModel.fromJson(empresaJson)
          : EmpresaModel();
      _isAuth = _token.isNotEmpty;
      notifyListeners();
    } else {
      _token = "";
      _usuarioLogado = "";
      _empresaModel = EmpresaModel();
      _isAuth = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String token) async {
    try {
      _token = token;
      _usuarioLogado = email;
      _isAuth = true;
      await _prefs.setString(Keys.token, token);
      await _prefs.setString(Keys.usuarioLogado, email);
      notifyListeners();
    } catch (e) {
      _isAuth = false;
      _token = "";
      _usuarioLogado = "";
      await _prefs.remove(Keys.token);
      await _prefs.remove(Keys.usuarioLogado);
      notifyListeners();
    }
  }

  Future<void> registrarEmpresa(String email, String tokenR) async {
    _token = tokenR;
    _usuarioLogado = email;
    _isAuth = true;
    await _prefs.setString(Keys.token, tokenR);
    await _prefs.setString(Keys.usuarioLogado, email);
    notifyListeners();
  }

  Future<void> atualizarUsuario() async {
    try {
      _empresaModel = await _loginRepository.buscaInfoEmpresa();
      await _prefs.setString(Keys.empresaModel, _empresaModel.toJson());
      notifyListeners();
    } catch (e) {
      _empresaModel = EmpresaModel();
      await _prefs.remove(Keys.empresaModel);
      notifyListeners();
    }
  }

  Future<bool> verificarAcessoPremium() async {
    try {
      bool isPremium = await _loginRepository.verificarAcessoPremium();
      return isPremium;
    } catch (e) {
      return false;
    }
  }

  String get token => _token;
  bool get isAuth => _isAuth;
  String get usuarioLogado => _usuarioLogado;
  EmpresaModel get empresaModel => _empresaModel;

  void logout() async {
    _isAuth = false;
    _token = '';
    _usuarioLogado = '';
    _empresaModel = EmpresaModel();
    await _prefs.remove(Keys.token);
    await _prefs.remove(Keys.empresaModel);
    await _prefs.remove(Keys.usuarioLogado);
    await _prefs.clear();
    notifyListeners();
  }
}
