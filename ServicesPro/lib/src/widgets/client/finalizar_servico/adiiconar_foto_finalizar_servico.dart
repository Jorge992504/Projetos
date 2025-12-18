import 'dart:io';

import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/widgets/add_photo_content.dart';

class AdiiconarFotoFinalizarServico extends StatelessWidget {
  final bool isDark;
  final File? image;
  final VoidCallback onTap;
  const AdiiconarFotoFinalizarServico({
    super.key,
    required this.isDark,
    this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isDark
              ? Theme.of(context).colorScheme.surface
              : ColorsConstants.secundaryColor.withOpacity(0.15),
          border: Border.all(
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.letrasColor,
          ),
        ),
        child: image == null
            ? AddPhotoContent()
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
      ),
    );
  }
}
