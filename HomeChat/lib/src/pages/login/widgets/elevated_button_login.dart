import 'package:flutter/material.dart';

import 'package:homechat/src/ui/sizes/size_screen.dart';

class ElevatedButtonLogin extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const ElevatedButtonLogin({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: context.screenMetWidth(0.4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
