import 'package:aumigo/core/rest_client/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBanding extends StatelessWidget {
  final Widget child;
  const ApplicationBanding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RestClient>(
          create: (context) => RestClient(),
        ),
      ],
      child: child,
    );
  }
}
