import 'package:activovo/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationProvider extends StatelessWidget {
  final Widget child;

  const ApplicationProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider(create: (context) => CustomDio(),),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          lazy: false,
        )
      ],
      child: child,
    );
  }
}
