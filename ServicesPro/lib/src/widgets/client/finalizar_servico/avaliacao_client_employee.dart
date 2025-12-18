import 'package:flutter/material.dart';

class AvaliacaoClientEmployee extends StatelessWidget {
  final int rating; // 1 a 5
  final ValueChanged<int>? onRatingChanged;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  const AvaliacaoClientEmployee({
    super.key,
    required this.rating,
    this.onRatingChanged,
    required this.size,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isActive = starIndex <= rating;

        return GestureDetector(
          onTap: onRatingChanged == null
              ? null
              : () => onRatingChanged!(starIndex),
          child: Icon(
            isActive ? Icons.star : Icons.star_border,
            size: size,
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
