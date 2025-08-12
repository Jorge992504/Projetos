import 'package:consucep/core/theme/app_theme.dart';
import 'package:consucep/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ConsuCep());
}

class ConsuCep extends StatelessWidget {
  const ConsuCep({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta de CEP',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
