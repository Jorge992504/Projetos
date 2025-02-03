import 'package:activovo/src/models/model_disease.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';

import 'package:flutter/material.dart';

class CheckDoencas extends StatefulWidget {
  final ModelDisease diseaseModel;

  final ValueChanged<ModelDisease> onPresses;
  const CheckDoencas({
    super.key,
    required this.diseaseModel,
    required this.onPresses,
  });

  @override
  State<CheckDoencas> createState() => _CheckDoencas();
}

class _CheckDoencas extends State<CheckDoencas> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  activeColor: ColorsConstants.greyAppBar,
                  checkColor: ColorsConstants.greyEntryF,
                  side: const BorderSide(
                      color: ColorsConstants.greyAppBar, width: 2),
                  value: isChecked,
                  onChanged: (value) => {
                        setState(() {
                          isChecked = !isChecked;
                          widget.onPresses(widget.diseaseModel);
                        })
                      }),
              const SizedBox(
                width: 1,
              ),
              Flexible(
                child: Text(
                  widget.diseaseModel.name,
                  style: context.fontes.textLight.copyWith(
                    color: ColorsConstants.greyTitulos,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
