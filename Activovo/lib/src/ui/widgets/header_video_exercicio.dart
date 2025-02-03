import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

class HeaderVideoExercicio extends StatefulWidget {
  final String label;
  final String video;
  final int labelSeries;
  final int labelRepetitions;
  const HeaderVideoExercicio({
    super.key,
    required this.label,
    required this.video,
    required this.labelSeries,
    required this.labelRepetitions,
  });

  @override
  State<HeaderVideoExercicio> createState() => _HeaderVideoExercicioState();
}

class _HeaderVideoExercicioState extends State<HeaderVideoExercicio> {
  late Widget videoWidget;
  @override
  void initState() {
    super.initState();
    videoWidget = const Text('');
  }

  var selected = false;
  @override
  Widget build(BuildContext context) {
    final iconButton = selected
        ? const Icon(
            Icons.pause,
            color: ColorsConstants.greyBotoes,
          )
        : const Icon(
            Icons.play_arrow,
            color: ColorsConstants.greyBotoes,
          );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          width: context.WidthScreenM(0.9),
          height: 200,
          decoration: BoxDecoration(
            color: ColorsConstants.greyEntryF,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorsConstants.greyFundoB,
            ),
          ),
          child: videoWidget,
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          width: context.WidthScreenM(0.9),
          height: context.WidthScreenM(0.5),
          // decoration: BoxDecoration(
          //   color: ColorsConstants.greyEntryF,
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(
          //     color: ColorsConstants.greyFundoB,
          //   ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.label,
                  style: context.fontes.textMedium.copyWith(
                    fontSize: 18,
                    color: ColorsConstants.greyTitulos,
                  ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quantidade de series: ${widget.labelSeries.toString()}',
                  style: context.fontes.textMedium.copyWith(
                    fontSize: 14,
                    color: ColorsConstants.greyTitulos,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quantidade de repetições: ${widget.labelRepetitions.toString()}',
                  style: context.fontes.textMedium.copyWith(
                    fontSize: 14,
                    color: ColorsConstants.greyTitulos,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: context.WidthScreenM(0.9),
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selected = !selected;
                // videoWidget = NativeVideoView(
                //   onCreated: (controller) {
                //     controller.setVideoSource(
                //       widget.video,
                //       requestAudioFocus: true,
                //       sourceType: VideoSourceType.network,
                //     );
                //   },
                //   onPrepared: (controller, info) {
                //     if (selected == true) {
                //       controller.play();
                //       info.duration;
                //     } else {
                //       controller.pause();
                //       const Center(child: Text('PAUSE'));
                //     }
                //   },
                //   onCompletion: (controller) {
                //     controller.pause();
                //   },
                // );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Começar',
                  style: context.fontes.textBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.greyBotoes,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: iconButton,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
