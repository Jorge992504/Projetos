import 'package:aumigo/core/providers/application_banding.dart';
import 'package:flutter/material.dart';

class AumigoApp extends StatelessWidget {
  const AumigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApplicationBanding(
      child: MaterialApp(
        title: "Aumigo",
      ),
    );
  }
}
