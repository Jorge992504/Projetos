import 'dart:developer';

import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String nome =
        Provider.of<AuthProvider>(context, listen: false).userModel.name;
    String token = Provider.of<AuthProvider>(context, listen: false).token;

    String getNome() {
      if (nome.isEmpty) {
        return "";
      }
      String nomefinal = "";
      List<String> nomes = nome.split(" ");
      if (nomes.length > 1) {
        nomefinal = '${nomes[0][0]}${nomes[nomes.length - 1][0]}';
      } else {
        try {
          nomefinal = nomes[0].substring(0, 2);
        } catch (e) {
          nomefinal = nome;
        }
      }
      return nomefinal;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorsConstants.fundoCard),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Faltou nada né',
              style: context.fontesLetras.textThin.copyWith(
                fontSize: 20,
                color: ColorsConstants.fundoCard,
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(
                ImageConstants.piscada16,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      endDrawer: SafeArea(
        child: Drawer(
          backgroundColor: ColorsConstants.textos,
          child: Stack(
            children: [
              ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      nome.toUpperCase(),
                      style: context.fontesLetras.textLight
                          .copyWith(fontSize: 14, color: ColorsConstants.black),
                    ),
                    accountEmail: Text(
                      'email',
                    ),
                    decoration: const BoxDecoration(
                      color: ColorsConstants.appBar,
                    ),
                    currentAccountPicture: CircleAvatar(
                      // backgroundColor: AppColors.instance.tela,
                      child: Text(
                        getNome(),
                        style: context.fontesLetras.textLight.copyWith(
                          fontSize: 25,
                          color: ColorsConstants.appBar,
                        ),
                      ),
                    ),
                    currentAccountPictureSize: const Size.square(60),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_sharp),
                    title: const Text(
                      "Sair",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      log("---------------token-----------------$token");
                    },
                  ),
                ],
              ),
              const Positioned(
                bottom: 10,
                right: 12,
                child: Text(
                  'versao',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
