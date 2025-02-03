import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saborito/app/core/rest_client/custom_dio.dart';

class ProviderBinding extends StatelessWidget {
  final Widget child;
  const ProviderBinding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
      ],
      child: child,
    );
  }
}
