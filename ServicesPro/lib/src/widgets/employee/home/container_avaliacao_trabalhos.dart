import 'package:flutter/material.dart';

class ContainerAvaliacaoTrabalhos extends StatelessWidget {
  final String label1;
  final String label2;
  final IconData? icon;
  final Color? color;
  const ContainerAvaliacaoTrabalhos({
    super.key,
    required this.label1,
    required this.label2,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 4),
          Text(
            label1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
