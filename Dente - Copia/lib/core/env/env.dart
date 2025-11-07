import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Env? _env;
  Env._();
  static Env get env {
    _env ??= Env._();
    return _env!;
  }

  Future<void> load() => dotenv.load();

  String? operator [](String key) => dotenv.env[key];
}
