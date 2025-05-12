class ImagemModelo {
  final int? id;
  final String caminho;
  final String dataHora;

  ImagemModelo({
    this.id,
    required this.caminho,
    required this.dataHora,
  });

  Map<String, dynamic> paraMapa() {
    return {
      'id': id,
      'caminho': caminho,
      'data_hora': dataHora,
    };
  }

  factory ImagemModelo.deMapa(Map<String, dynamic> mapa) {
    return ImagemModelo(
      id: mapa['id'],
      caminho: mapa['caminho'],
      dataHora: mapa['data_hora'],
    );
  }
}
