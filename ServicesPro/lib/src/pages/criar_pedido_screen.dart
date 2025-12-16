// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/formater_value.dart';

class CriarPedidoScreen extends StatefulWidget {
  const CriarPedidoScreen({super.key});

  @override
  State<CriarPedidoScreen> createState() => _CriarPedidoScreenState();
}

class _CriarPedidoScreenState extends State<CriarPedidoScreen> {
  List<Categorias> categorias = [
    Categorias(id: 1, nome: "Serviços Domésticos"),
    Categorias(id: 2, nome: "Reparos e Manutenção"),
    Categorias(id: 3, nome: "Mudança, Transporte e Entregas"),
    Categorias(id: 4, nome: "Beleza e Estética"),
    Categorias(id: 5, nome: "Tecnologia"),
    Categorias(id: 6, nome: "Área Pet"),
    Categorias(id: 7, nome: "Fitness e Bem-estar"),
    Categorias(id: 8, nome: "Consultoria e Profissionais Especializados"),
    Categorias(id: 9, nome: "Eventos"),
    Categorias(id: 10, nome: "Automotivo"),
    Categorias(id: 11, nome: "Reforma e Construção"),
    Categorias(id: 12, nome: "Segurança"),
    Categorias(id: 13, nome: "Serviços Administrativos"),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicar Serviço'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Novo serviço.",
                style: context.cusotomFontes.black.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 14),
              Text(
                "Preencha os campos para realizar sua solicitação.",
                style: context.cusotomFontes.regular.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 14),
              Text(
                "Titulo do serviço.",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(0.9),
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    hintText: 'Ex: Instalação de ar condicionado',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Descrição do serviço requerido.",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(0.9),
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: null, // permite infinitas linhas
                  minLines: 3, // começa com 3 linhas
                  keyboardType: TextInputType.multiline,
                  textAlignVertical:
                      TextAlignVertical.top, // melhor para multiline
                  cursorHeight: 18,
                  decoration: const InputDecoration(
                    hintText:
                        'Ex: Descreva com detalhes o serviço que está procurando para facilitar para o profissional.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Categoria.",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: 400,
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField2<String>(
                  // focusNode: nmDentistaFocus,
                  // value: nmDentistaController.text.isEmpty
                  //     ? null
                  //     : nmDentistaController.text,
                  decoration: InputDecoration(
                    hintText: "Informe a categoria",

                    hintStyle: TextStyle(
                      color: !isDark
                          ? ColorsConstants.letrasColor
                          : ColorsConstants.primaryColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        // color: !isDark
                        //     ? ColorsConstants.letrasColor
                        //     : ColorsConstants.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: !isDark
                            ? ColorsConstants.letrasColor
                            : ColorsConstants.primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                  ),
                  isExpanded: true,
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: !isDark
                          ? ColorsConstants.letrasColor
                          : ColorsConstants.primaryColor,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    direction: DropdownDirection
                        .textDirection, // 👈 força abrir para baixo
                    maxHeight: 300,
                    offset: const Offset(
                      0,
                      8,
                    ), // pequeno espaçamento abaixo do campo
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // color: !isDark
                      //     ? ColorsConstants.letrasColor
                      //     : ColorsConstants.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          // color: !isDark
                          //     ? ColorsConstants.letrasColor
                          //     : ColorsConstants.primaryColor,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  items: categorias.map((categoria) {
                    // dentista.id;
                    return DropdownMenuItem<String>(
                      value: categoria.nome,
                      child: Text(
                        categoria.nome ?? '',
                        style: context.cusotomFontes.regular.copyWith(
                          fontSize: 16,
                          color: !isDark
                              ? ColorsConstants.letrasColor
                              : ColorsConstants.primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      // nmDentistaController.text = value ?? '';
                      // dentistasDisponiveis
                      //     .where((dentista) => dentista.nome == value.toString())
                      //     .forEach((dentista) {
                      //       idDentista = dentista.id!;
                      //     });
                    });
                    // FocusScope.of(context).requestFocus(dataFocus);
                  },
                ),
              ),

              const SizedBox(height: 14),
              Text(
                "Valor oferecido (desde).",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(0.9),
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    hintText: 'Ex: 80',
                    border: InputBorder.none,
                  ),
                  inputFormatters: [FormaterValue()],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Valor oferecido (até).",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(0.9),
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    hintText: 'Ex: 180',
                    border: InputBorder.none,
                  ),
                  inputFormatters: [FormaterValue()],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Endereço.",
                style: context.cusotomFontes.bold.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(0.9),
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on_rounded, size: 25),
                    ),
                    isDense: true,
                    hintText:
                        'Ex: Rua Rui Barbosa, 99 E Bairro Centro, Municipio',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: context.percentWidth(1),
                height: 50,
                // padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  // color: isDark
                  //     ? Theme.of(context).colorScheme.surface
                  //     : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Enviar solicitação",
                    style: context.cusotomFontes.bold.copyWith(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}

class Categorias {
  int? id;
  String? nome;
  Categorias({this.id, this.nome});
}
