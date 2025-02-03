import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

class WeekDaysPanel extends StatelessWidget {
  final ValueChanged<String> onDaysPressed;
  const WeekDaysPanel({super.key, required this.onDaysPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecione os dias da semana',
            style: context.fontes.textExtraBold.copyWith(
              fontSize: 18,
              color: ColorsConstants.greyTitulos,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(
                  label: 'Seg',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Ter',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Qua',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Qui',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Sex',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Sab',
                  onDaysPressed: onDaysPressed,
                ),
                ButtonDay(
                  label: 'Dom',
                  onDaysPressed: onDaysPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;
  final ValueChanged<String> onDaysPressed;
  const ButtonDay({
    super.key,
    required this.label,
    required this.onDaysPressed,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.greyAppBar;
    var buttonColor =
        selected ? ColorsConstants.greyAppBar : ColorsConstants.greyEntryF;
    final buttonBorderColor =
        selected ? ColorsConstants.greyAppBar : ColorsConstants.greyEntryF;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          widget.onDaysPressed(widget.label);
          setState(() {
            selected = !selected;
          });
        },
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
