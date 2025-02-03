//AppBar(
      //   elevation: 6,
      //   backgroundColor: Colors.blueGrey[100],
      //   leading: Builder(
      //     builder: ((context) {
      //       return IconButton(
      //         icon: const Icon(Icons.menu),
      //         color: Colors.black,
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     }),
      //   ),
      // ),
      // drawer: SafeArea(
      //   child: Drawer(
      //     backgroundColor: Colors.blueGrey[100],
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: [
      //         UserAccountsDrawerHeader(
      //           accountName: Text(
      //             widget.usuario.nome,
      //             style: context.textEstilo.textMedium.copyWith(fontSize: 13),
      //           ),
      //           accountEmail: Text(
      //             widget.usuario.email,
      //             style: context.textEstilo.textLight.copyWith(fontSize: 16),
      //           ),
      //           currentAccountPicture: CircleAvatar(
      //             // ignore: unrelated_type_equality_checks
      //             backgroundColor:
      //                 Theme.of(context).platform == TargetPlatform.android
      //                     ? Colors.blue
      //                     : Colors.white,
      //             child: Image.network(widget.usuario.foto),
      //           ),
      //           decoration: const BoxDecoration(
      //             color: Colors.blueGrey,
      //           ),
      //         ),
      //         ListTile(
      //           trailing: const Icon(
      //             Icons.account_circle,
      //             color: Colors.blue,
      //           ),
      //           title: Text(
      //             'Perfil',
      //             style: context.textEstilo.textMedium
      //                 .copyWith(fontSize: 15, color: Colors.black87),
      //           ),
      //           textColor: Colors.grey,
      //           onTap: () {
      //             // Navigator.of(context).pushNamed(Rotas.perfil);
      //           },
      //         ),
      //         ListTile(
      //           trailing: const Icon(
      //             Icons.exit_to_app,
      //             color: Colors.red,
      //           ),
      //           title: Text(
      //             'Sair',
      //             style: context.textEstilo.textMedium
      //                 .copyWith(fontSize: 15, color: Colors.black87),
      //           ),
      //           textColor: Colors.grey,
      //           onTap: () {
      //             Provider.of<AuthProvider>(context, listen: false).sair();
      //             Navigator.of(context)
      //                 .pushNamedAndRemoveUntil(Rotas.login, (route) => false);
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),