import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final double? widthImage;
  final double? heightImage;
  final EdgeInsetsGeometry? paddingImage;
  final EdgeInsetsGeometry? marginImage;
  final Widget? childImage;
  final AlignmentGeometry? alignmentImage;
  final List<Widget>? children;
  const CustomItem({
    super.key,
    this.widthImage,
    this.heightImage,
    this.paddingImage,
    this.marginImage,
    this.childImage,
    this.alignmentImage,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: widthImage,
          height: heightImage,
          padding: paddingImage,
          margin: marginImage,
          alignment: alignmentImage,
          child: childImage,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: children ?? [],
          ),
        ),
      ],
    );
  }
}
