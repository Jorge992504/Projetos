import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/formatar_cpf.dart';
import 'package:servicespro/core/ui/widgets/formatar_data.dart';
import 'package:servicespro/core/ui/widgets/formatar_telefone.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class CustomClientDados extends StatelessWidget {
  final TextEditingController dataController;
  final TextEditingController cpfController;
  final TextEditingController telefoneController;
  final TextEditingController enderecoController;
  final FocusNode dataFocus;
  final FocusNode cpfFocus;
  final FocusNode telefoneFocus;
  final FocusNode enderecoFocus;
  const CustomClientDados({
    super.key,
    required this.dataController,
    required this.cpfController,
    required this.telefoneController,
    required this.enderecoController,
    required this.dataFocus,
    required this.cpfFocus,
    required this.telefoneFocus,
    required this.enderecoFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'CPF',
            labelStyle: context.cusotomFontes.regular.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
              fontSize: 16,
            ),
            hintText: 'Digite seu CPF',
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
            CpfInputFormatter(),
          ],
          textInputAction: TextInputAction.next,
          focusNode: cpfFocus,
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
          textInputAction: TextInputAction.next,
          focusNode: dataFocus,
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
          textInputAction: TextInputAction.next,
          focusNode: telefoneFocus,
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
          textInputAction: TextInputAction.done,
          controller: enderecoController,
          focusNode: enderecoFocus,
        ),
      ],
    );
  }
}
