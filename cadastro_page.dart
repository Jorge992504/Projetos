import 'package:activovo/rotas/rotas_pages.dart';
import 'package:activovo/size_tela/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool isCheck = false;
  final formKey = GlobalKey<FormState>();
  //controlar login
  final nomeCad = TextEditingController();
  final sobrenomeCad = TextEditingController();
  final dataNacsCad = TextEditingController();
  final pecoCad = TextEditingController();
  final alturaCad = TextEditingController();
  final doencaSimCad = TextEditingController();
  final doencaCad = TextEditingController();
  final usuaCad = TextEditingController();
  final senhaCad = TextEditingController();
  final confirSenhaCad = TextEditingController();

  @override
  void dispose() {
    nomeCad.dispose();
    sobrenomeCad.dispose();
    dataNacsCad.dispose();
    pecoCad.dispose();
    alturaCad.dispose();
    doencaSimCad.dispose();
    doencaCad.dispose();
    usuaCad.dispose();
    senhaCad.dispose();
    confirSenhaCad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextField(
                      controller: nomeCad,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: FaIcon(FontAwesomeIcons.circleUser),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 28,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextField(
                      controller: sobrenomeCad,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          labelText: 'Sobrenome',
                          labelStyle: TextStyle(color: Colors.black),
                          //prefixIcon: FaIcon(FontAwesomeIcons.circleUser),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 28,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextField(
                      controller: dataNacsCad,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          labelText: 'Idade',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: FaIcon(FontAwesomeIcons.calendarDays),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 28,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextField(
                      controller: pecoCad,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          labelText: 'Preço',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: FaIcon(FontAwesomeIcons.weightScale),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 28,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextField(
                      controller: alturaCad,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          labelText: 'Altura',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: FaIcon(FontAwesomeIcons.ruler),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 24,
                            minWidth: 28,
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: CheckboxListTile(
                      value: isCheck,
                      onChanged: (value) => setState(() {
                        isCheck = value!;
                        if (isCheck) {
                          doencaCad.clear();
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
                        controller: doencaCad,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 10.0),
                            labelText: 'Tipo de doença',
                            labelStyle: TextStyle(color: Colors.black),
                            //prefixIcon: FaIcon(FontAwesomeIcons.heart),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 24,
                              minWidth: 28,
                            ),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).popAndPushNamed(RotasPages.inicio); //provisorio
        },
      ),
    );
  }
}
