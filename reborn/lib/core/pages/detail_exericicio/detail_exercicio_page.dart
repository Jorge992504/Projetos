import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/modelos/modelo_exercicios.dart';

import 'package:reborn/core/widgets/reborn_app_bar.dart';
import 'package:video_player/video_player.dart';

class DetailExercicioPage extends StatefulWidget {
  final ModeloExercicio exercicio;
  const DetailExercicioPage({super.key, required this.exercicio});

  @override
  State<DetailExercicioPage> createState() => _DetailExercicioPageState();
}

class _DetailExercicioPageState extends State<DetailExercicioPage> {
  bool isEnabled = false;
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller =
        VideoPlayerController.contentUri(Uri.parse(widget.exercicio.video));
    try {
      await _controller.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false, // Não inicia automaticamente
        looping: false, // Não faz loop
      );
      setState(() {});
      _controller.addListener(() {
        if (_controller.value.isInitialized) {
          setState(() {});
        }
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar vídeo: $e')),
      );
    }
  }

  String _getProgessText() {
    if (!_isInitialized) {
      return '0%';
    }
    final currentPosition = _controller.value.position.inSeconds.toDouble();
    final duration = _controller.value.duration.inSeconds.toDouble();
    if (duration > 0) {
      return '${((currentPosition / duration) * 100).toStringAsFixed(0)}%';
    }
    return '0%';
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller =
  //       VideoPlayerController.networkUrl(Uri.parse(widget.exercicio.video));

  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RebornAppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            width: context.screenLargura,
            height: 200,
            // decoration: BoxDecoration(color: Colors.blue[100]),
            child: Center(
//------------------------------------------------------------------------------
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
//------------------------------------------------------------------------------
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: context.screenLargura,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Row(
              children: [
                Center(
                  child: IconButton(
                    onPressed: _togglePlayPause,
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.play_circle_sharp
                          : Icons.pause_circle_sharp,
                      color: Colors.green[500],
                    ),
                    iconSize: 35,
                  ),
                ),
                Center(
                  child: Text(
                    widget.exercicio.nome,
                    style: context.textEstilo.textRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(left: 120),
                  width: 30,
                  height: 20,
                  // decoration: BoxDecoration(
                  //   color: Colors.blue[100],
                  // ),
                  child: Text(
                    _getProgessText(),
                    style: context.textEstilo.textLight.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
            width: context.screenLargura,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.exercicio.descricao,
                  style: context.textEstilo.textMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
