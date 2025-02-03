import 'package:flutter/material.dart';

class CriarTreinoButton extends StatefulWidget {
  final Widget label;
  final VoidCallback? onPressed;
  const CriarTreinoButton({super.key, required this.label, this.onPressed});

  @override
  State<CriarTreinoButton> createState() => _CriarTreinoButton();
}

class _CriarTreinoButton extends State<CriarTreinoButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 5,
      child: SizedBox(
        width: 110,
        height: 30,
        child: FloatingActionButton.extended(
          onPressed: widget.onPressed,
          label: widget.label,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
