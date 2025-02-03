import 'package:flutter/material.dart';

class SbtButton extends StatelessWidget {
  final String label;
  final double? width;
  final double height;
  final VoidCallback? onPresses;

  const SbtButton({
    super.key,
    required this.label,
    this.onPresses,
    this.width,
    this.height = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPresses,
        child: Text(label),
      ),
    );
  }
}
