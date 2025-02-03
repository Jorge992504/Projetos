import 'package:flutter/material.dart';
import 'package:introducao_flutter/singleton_patterm.dart';

extension SinglentonBuildContext on BuildContext {
  int get id => SingletonPatterm.instance.id ?? 0;
}
//context almacena codigos prontos, como para mudar uma cor