// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:activovo/core/models/exercicio.dart';
//import 'package:activovo/pages_controll/exercicio_componentes/exercicio_card.dart';
//import 'package:activovo/rotas/rotas_pages.dart';
//import 'dart:ui';

//import 'package:activovo/rotas/rotas_pages.dart';
//import 'package:activovo/rotas/rotas_pages.dart';
import 'package:flutter/material.dart';

import 'package:activovo/size_tela/size_extensions.dart';
import 'package:native_video_view/native_video_view.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class HomeExercicio extends StatefulWidget {
  const HomeExercicio({super.key});

  @override
  State<HomeExercicio> createState() => _HomeExercicioState();
}

class _HomeExercicioState extends State<HomeExercicio> {
  late Widget _selectWidget;
  //late YoutubePlayerController _controller;

  @override
  void initState() {
    _selectWidget = Image.asset(
      'assets/images/alongamento.png',
      fit: BoxFit.cover,
    );

    super.initState();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 6,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 230,
              child: _selectWidget,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          //----------------lista de exercicios---------------------------------------
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/videos/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Exercicio 1º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/videos/teste2.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Exercicio 2º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/videos/teste3.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Exercicio 3º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 4º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 5º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 6º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 7º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 8º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.green[200],
            child: SizedBox(
              width: context.screenWidth,
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      color: Colors.black,
                      onPressed: () {
                        //---------------add video na tela----------------------------
                        setState(() {
                          _selectWidget = NativeVideoView(
                            onPrepared: (controller, info) {
                              controller.play();
                            },
                            onError: (controller, what, extra, message) {},
                            onCompletion: (controller) {},
                            onProgress: (progress, duration) {},
                            onCreated: (controller) {
                              controller.setVideoSource(
                                'assets/images/teste.mp4',
                                requestAudioFocus: true,
                                sourceType: VideoSourceType.asset,
                              );
                            },
                          );
                          //------------------------------------------------------------
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Nome do exercicio 9º',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // //--------------------------exercicio 9-------------------------------
          // Card(
          //   elevation: 4,
          //   color: Colors.green[200],
          //   child: SizedBox(
          //     width: context.screenWidth,
          //     height: 40,
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Row(
          //         children: [
          //           IconButton(
          //             icon: const Icon(Icons.play_arrow),
          //             color: Colors.black,
          //             onPressed: () {
          //               //---------------add video na tela----------------------------
          //               setState(() {
          //                 _controller = YoutubePlayerController(
          //                   initialVideoId: '4-4f10fL1pw',
          //                   flags: const YoutubePlayerFlags(
          //                     isLive: true,
          //                   ),
          //                 );
          //                 // _controller.initialVideoId = "4-4f10fL1pw";

          //                 _selectWidget = YoutubePlayer(
          //                   controller: _controller,
          //                   showVideoProgressIndicator: true,
          //                   progressIndicatorColor: Colors.amber,
          //                   progressColors: const ProgressBarColors(
          //                     playedColor: Colors.amber,
          //                     handleColor: Colors.amberAccent,
          //                   ),
          //                 );
          //                 //------------------------------------------------------------
          //               });
          //             },
          //           ),
          //           Container(
          //             margin: const EdgeInsets.only(left: 10),
          //             child: const Text(
          //               'Nome do exercicio º',
          //               style: TextStyle(fontSize: 16),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
