import 'package:flutter/material.dart';

class DayTraning extends StatelessWidget {
  final String label;
  const DayTraning({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label),
      ),
    );
  }
}
