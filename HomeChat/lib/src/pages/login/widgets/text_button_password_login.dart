import 'package:flutter/material.dart';

class TextButtonPasswordLogin extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const TextButtonPasswordLogin(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 150,
      child: InkWell(
          onTap: onPressed,
          child: Text(
            label,
            style: const TextStyle(color: Colors.blue),
          )),
    );
  }
}
