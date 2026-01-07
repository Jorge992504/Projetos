import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/formatar_cnpj.dart';
import 'package:servicespro/core/ui/widgets/formatar_cpf.dart';
import 'package:servicespro/core/ui/widgets/formatar_data.dart';
import 'package:servicespro/core/ui/widgets/formatar_telefone.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/pages/register_client_employee_screen.dart';

class CustomEmployeeDados extends StatelessWidget {
  final TextEditingController dataController;
  final TextEditingController cpfController;
  final TextEditingController telefoneController;
  final List<String> tiposPessoa;
  final String pessoaSelecionada;
  final void Function(String?)? onChangedPF;
  final void Function(String?)? onChangedPJ;
  final void Function(String?)? onChangedSleecionaCategoria;
  final List<CategoriasClientEmployee> categorias;
  const CustomEmployeeDados({
    super.key,
    required this.dataController,
    required this.cpfController,
    required this.telefoneController,
    required this.pessoaSelecionada,
    required this.tiposPessoa,
    this.onChangedPF,
    this.onChangedPJ,
    this.onChangedSleecionaCategoria,
    required this.categorias,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Radio(
              value: tiposPessoa[0],
              groupValue: pessoaSelecionada,
              onChanged: onChangedPF,
              activeColor: ColorsConstants.azulColor,
            ),
            Expanded(
              child: Text(
                'Pessoa Física (PF)',
                style: context.cusotomFontes.regular.copyWith(
                  color: TemaSistema().temaSistema(context)
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                  fontSize: 12,
                ),
              ),
            ),
            Radio(
              value: tiposPessoa[1],
              groupValue: pessoaSelecionada,
              onChanged: onChangedPJ,
              activeColor: ColorsConstants.azulColor,
            ),
            Expanded(
              child: Text(
                'Pessoa Jurídica (PJ)',
                style: context.cusotomFontes.regular.copyWith(
                  color: TemaSistema().temaSistema(context)
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: pessoaSelecionada == 'PF' ? 'CPF' : 'CNPJ',
            labelStyle: context.cusotomFontes.regular.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
              fontSize: 16,
            ),
            hintText: pessoaSelecionada == 'PF'
                ? 'Digite seu CPF'
                : 'Digite seu CNPJ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.telaColor
                    : ColorsConstants.letrasColor,
                width: 2,
              ),
            ),
          ),

          cursorHeight: 18,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          controller: cpfController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            pessoaSelecionada == 'PF'
                ? CpfInputFormatter()
                : CnpjInputFormatter(),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Data de Nascimento',
            labelStyle: context.cusotomFontes.regular.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
              fontSize: 16,
            ),
            hintText: 'DD/MM/AAAA',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.telaColor
                    : ColorsConstants.letrasColor,
                width: 2,
              ),
            ),
          ),
          controller: dataController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DateInputFormatter(),
          ],
          cursorHeight: 18,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Telefone',
            labelStyle: context.cusotomFontes.regular.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
              fontSize: 16,
            ),
            hintText: 'Digite seu telefone',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.telaColor
                    : ColorsConstants.letrasColor,
                width: 2,
              ),
            ),
          ),

          cursorHeight: 18,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          inputFormatters: [TelefoneInputFormatter()],
          controller: telefoneController,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Endereço',
            labelStyle: context.cusotomFontes.regular.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
              fontSize: 16,
            ),
            hintText: 'Digite seu endereço',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.telaColor
                    : ColorsConstants.letrasColor,
                width: 2,
              ),
            ),
          ),

          cursorHeight: 18,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.streetAddress,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categoria.",
              style: context.cusotomFontes.bold.copyWith(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 400,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: TemaSistema().temaSistema(context)
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.telaColor,
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
                color: !TemaSistema().temaSistema(context)
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
                  color: !TemaSistema().temaSistema(context)
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
                color: !TemaSistema().temaSistema(context)
                    ? ColorsConstants.letrasColor
                    : ColorsConstants.primaryColor,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              direction:
                  DropdownDirection.textDirection, // 👈 força abrir para baixo
              maxHeight: 300,
              offset: const Offset(0, 8), // pequeno espaçamento abaixo do campo
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
                    color: !TemaSistema().temaSistema(context)
                        ? ColorsConstants.letrasColor
                        : ColorsConstants.primaryColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChangedSleecionaCategoria,
          ),
        ),
      ],
    );
  }
}
