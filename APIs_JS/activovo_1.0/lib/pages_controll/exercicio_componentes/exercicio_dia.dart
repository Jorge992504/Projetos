import 'package:flutter/material.dart';

class ExercicioDia extends StatelessWidget {
  final String label;
  const ExercicioDia({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        // Container(
        //   height: 13,
        //   width: 13,
        //   margin: const EdgeInsets.only(left: 240),
        //   decoration: const BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: Colors.red,
        //   ),
        // ),
        // Container(
        //   height: 13,
        //   width: 16,
        //   margin: const EdgeInsets.only(left: 2),
        //   decoration: const BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: Colors.red,
        //   ),
        // ),
        // Container(
        //   height: 13,
        //   width: 19,
        //   margin: const EdgeInsets.only(left: 0),
        //   decoration: const BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: Colors.red,
        //   ),
        // ),
      ],
    );
  }
}
