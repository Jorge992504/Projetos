import 'package:flutter/material.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';

class HomeProducts extends StatefulWidget {
  final String label;
  final ValueChanged<int> onPressed;
  final String photo;
  final int id;
  const HomeProducts({
    super.key,
    required this.label,
    required this.onPressed,
    required this.photo,
    required this.id,
  });

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        widget.onPressed(widget.id);
      },
      child: Container(
        width: 100,
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorsConstants.fundoCard,
          border: const Border(
            bottom: BorderSide(
              color: ColorsConstants.label,
              width: 3,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   color: ColorsConstants.fundoCard,
                //   border: const Border(
                //     bottom: BorderSide(
                //       color: ColorsConstants.label,
                //       // width: 3,
                //     ),
                //   ),
                // ),
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    
                    message: widget.label,
                    child: Text(
                      widget.label.isNotEmpty ? widget.label : widget.label,
                      // widget.label,
                      style: context.fontes.textBold.copyWith(
                        color: ColorsConstants.label,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8),
              //   color: ColorsConstants.fundoCard,
              //   border: const Border(
              //     bottom: BorderSide(
              //       color: ColorsConstants.label,
              //       // width: 3,
              //     ),
              //   ),
              // ),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
