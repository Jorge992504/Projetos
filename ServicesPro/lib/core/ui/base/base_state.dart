import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/ui/loader/loader_tela.dart';
import 'package:servicespro/core/ui/messages/custom_messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T>
    with LaoderTela, CustomMessages {
  late final C controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {}
}
