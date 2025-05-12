import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> verificarConexao() async {
  final resultado = await Connectivity().checkConnectivity();
  // ignore: unrelated_type_equality_checks
  return resultado == ConnectivityResult.mobile ||
      // ignore: unrelated_type_equality_checks
      resultado == ConnectivityResult.wifi;
}
