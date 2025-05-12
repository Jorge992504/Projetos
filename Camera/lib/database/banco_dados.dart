import 'package:camera/models/image_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static final BancoDados _instancia = BancoDados._();
  static Database? _banco;

  BancoDados._();

  factory BancoDados() => _instancia;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    _banco = await _inicializarBanco();
    return _banco!;
  }

  Future<Database> _inicializarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'imagens.db');

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) async {
        await db.execute('''
          CREATE TABLE imagens (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            caminho TEXT NOT NULL,
            data_hora TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> salvarImagem(ImagemModelo imagem) async {
    final db = await banco;
    await db.insert('imagens', imagem.paraMapa());
  }

  Future<List<ImagemModelo>> listarImagens() async {
    final db = await banco;
    final List<Map<String, dynamic>> mapas = await db.query('imagens');
    return mapas.map((m) => ImagemModelo.deMapa(m)).toList();
  }
}
