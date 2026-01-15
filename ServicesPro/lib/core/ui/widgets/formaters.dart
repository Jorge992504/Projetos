class Formaters {
  static String formatarCPFCNPJ(String valor) =>
      valor.replaceAll(RegExp(r'[^0-9]'), '');
  static String dataParaAPI(String valor) {
    final partes = valor.split('/');
    if (partes.length != 3) return "";
    return "${partes[2]}-${partes[1]}-${partes[0]}";
  }

  static String formatarTelefoneAPI(String valor) =>
      valor.replaceAll(RegExp(r'[^0-9]'), '');
}
