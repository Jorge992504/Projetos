import 'package:flutter/material.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:ichat/app/src/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class WebSocketController extends StatefulWidget {
  final Widget child;
  const WebSocketController({super.key, required this.child});

  @override
  State<WebSocketController> createState() => _WebSocketControllerState();
}

class _WebSocketControllerState extends State<WebSocketController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).isAuthenticated
          ? context.read<WebSocketProvider>().conectar()
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
