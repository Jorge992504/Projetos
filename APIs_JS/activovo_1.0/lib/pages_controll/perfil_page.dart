// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:activovo/core/providers/auth_provider.dart';
//import 'dart:html';

//import 'package:activovo/core/providers/auth_provider.dart';---------------
import 'package:activovo/core/providers/auth_provider.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activovo/core/models/usuario.dart';
//import 'package:activovo/rotas/rotas_pages.dart';
import 'package:activovo/size_tela/size_extensions.dart';
//import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';-----------------------
//import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  final Usuario? user;
  const PerfilPage({
    super.key,
    required this.user,
  });
  @override
  State<PerfilPage> createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {
  final GlobalKey<_PerfilPage> myWidgetKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  //variaveis do perfil
  late TextEditingController nomeTextController;
  late TextEditingController sobrenomeTextController;
  late TextEditingController dataNacsTextController;
  late TextEditingController pecoTextController;
  late TextEditingController alturaTextController;
  late TextEditingController doencaSimTextController;
  late TextEditingController doencaTextController;
  late TextEditingController usuaTextController;
  late TextEditingController senhaTextController;
  late TextEditingController emailTextController;

  bool salvar = false;
  bool editar = true;
  bool cancelar = false;

  bool isCheck = false;
  bool isAdd = false;
  bool isHabilitados = false;
  Color color = const Color.fromARGB(255, 223, 221, 221);
  Color color2 = const Color.fromARGB(255, 223, 221, 221);
  Text text = const Text('Editar', style: TextStyle(fontSize: 12));
  int index = 0;
  bool isSenha = false;

  int currentPageIndex = 0;

  @override
  void dispose() {
    nomeTextController.dispose();
    sobrenomeTextController.dispose();
    dataNacsTextController.dispose();
    pecoTextController.dispose();
    alturaTextController.dispose();
    doencaSimTextController.dispose();
    doencaTextController.dispose();
    usuaTextController.dispose();
    senhaTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nomeTextController = TextEditingController(text: widget.user!.nome);
    sobrenomeTextController =
        TextEditingController(text: widget.user!.sobrenome);

//-------formatear data---------------------------------------------------------
    DateTime dataNasc = widget.user!.dataNasc;
    String dataNascFormatada = DateFormat('dd-MM-yyyy').format(dataNasc);
    dataNacsTextController = TextEditingController(text: dataNascFormatada);
//------------------------------------------------------------------------------
    pecoTextController =
        TextEditingController(text: widget.user!.peco.toString());
    alturaTextController =
        TextEditingController(text: widget.user!.altura.toString());
    doencaSimTextController =
        TextEditingController(text: widget.user!.doencaSim.toString());
    doencaTextController = TextEditingController(text: widget.user!.doenca);
    usuaTextController = TextEditingController(text: widget.user!.usua);
    senhaTextController = TextEditingController(text: widget.user!.senha);
    emailTextController = TextEditingController(text: widget.user!.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/fundo.png',
              fit: BoxFit.cover,
              width: context.screenWidth,
              height: context.screenHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 40, bottom: 40, right: 30),
              child: SizedBox(
                width: context.screenWidth,
                height: context.screenHeight,
                child: Card(
                  color: Colors.green[100],
                  elevation: 8,
                  child: Column(
                    children: [
//--------------------Nome------------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 60),
                        color: color2,
                        child: TextField(
                          controller: nomeTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabled: false,
                        ),
                      ),
//----------------------Sobrenome-----------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color2,
                        child: TextField(
                          controller: sobrenomeTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabled: false,
                        ),
                      ),
//--------------------Nascimento------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color2,
                        child: TextField(
                          controller: dataNacsTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabled: false,
                        ),
                      ),
//-------------------------Email------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color,
                        child: TextField(
                          controller: emailTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Insira o e-mail',
                          ),
                          enabled: isHabilitados,
                        ),
                      ),
//--------------------------Peço------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color,
                        child: TextField(
                          controller: pecoTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Insira o peço',
                          ),
                          enabled: isHabilitados,
                        ),
                      ),
//------------------------Altura------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color,
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: alturaTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Insira a altura',
                          ),
                          enabled: isHabilitados,
                        ),
                      ),
//--------------------doenca------------------------------------------------
                      SizedBox(
                        height: 55.0,
                        width: 300.0,
                        child: CheckboxListTile(
                          value: isCheck,
                          onChanged: (value) => setState(() {
                            isCheck = value!;
                            if (isCheck) {
                              doencaTextController.clear();
                            }
                          }),
                          title: const Text("Possui doença"),
                        ),
                      ),
                      SizedBox(
                        height: 55.0,
                        width: 300.0,
                        child: Visibility(
                          visible: isCheck,
                          child: TextField(
                            controller: doencaTextController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 10.0),
                                labelText: 'Tipo de doença',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Insira a doença',
                                //prefixIcon: FaIcon(FontAwesomeIcons.heart),
                                prefixIconConstraints: BoxConstraints(
                                  minHeight: 24,
                                  minWidth: 28,
                                ),
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 216, 214, 214)),
                          ),
                        ),
                      ),
//------------------------Usuario-----------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color2,
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: usuaTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabled: false,
                        ),
                      ),
//------------------------Senha-------------------------------------------------
                      Container(
                        margin:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        color: color,
                        child: TextField(
                          obscureText: isSenha,
                          textAlign: TextAlign.left,
                          controller: senhaTextController,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabled: isHabilitados,
                        ),
                      ),
//------------------------------------------------------------------------------
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 800),
              child: NavigationBar(
                onDestinationSelected: (int index) async {
                  if (index == 0) {
                    setState(() {
                      isHabilitados = true;
                      isSenha = true;
                      color = Colors.white;
                      salvar = true;
                      editar = false;
                      cancelar = true;
                    });
                  }
                  if (index == 1) {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .alterarUsuario(Usuario(
                      nome: widget.user!.nome,
                      sobrenome: widget.user!.sobrenome,
                      email: emailTextController.text,
                      dataNasc: widget.user!.dataNasc,
                      peco: double.parse(pecoTextController.text),
                      altura: double.parse(alturaTextController.text),
                      usua: usuaTextController.text,
                      senha: senhaTextController.text,
                      doencaSim: isCheck,
                      doenca: doencaTextController.text,
                    ));

                    if (context.mounted) {
                      setState(() {
                        isHabilitados = false;
                        color = const Color.fromARGB(255, 223, 221, 221);
                        editar = true;
                        salvar = false;
                        cancelar = false;
                      });
                    }
                  }
                },
                indicatorColor: Colors.amber,
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  Visibility(
                    visible: editar,
                    child: const NavigationDestination(
                      selectedIcon: Icon(
                        Icons.edit_calendar_rounded,
                        color: Colors.black,
                      ),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      label: 'Editar',
                    ),
                  ),
                  Visibility(
                    visible: salvar,
                    child: const NavigationDestination(
                      selectedIcon: Icon(
                        Icons.check_box,
                        color: Colors.black,
                      ),
                      icon: Icon(
                        Icons.check_box,
                        color: Colors.green,
                      ),
                      label: 'Salvar',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

//------------------------------------------------------------------------------
      ),
    );
  }
}
