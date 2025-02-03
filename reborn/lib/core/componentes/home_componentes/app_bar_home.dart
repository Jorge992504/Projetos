import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class AppBarHome extends StatefulWidget {
  final String titleLabel;
  const AppBarHome({
    super.key,
    required this.titleLabel,
  });

  @override
  State<AppBarHome> createState() => _AppBarHome();
}

class _AppBarHome extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 6,
      // backgroundColor: Colors.blueGrey[100],
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
      ],
      title: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.titleLabel,
          style: context.textEstilo.textBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.account_circle_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }
}
