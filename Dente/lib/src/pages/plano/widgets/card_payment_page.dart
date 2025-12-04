import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardPaymentPage extends StatelessWidget {
  final Function()? onPagar;
  final Function(String)? onChanged;
  final String iconeCartao;
  final TextEditingController? cartaoController;
  final TextEditingController? validadeController;
  final TextEditingController? cvvController;
  final TextEditingController? nomeController;
  final TextEditingController? cpfController;
  final TextEditingController? emailController;
  final FocusNode? cartaoFocus;
  final FocusNode? validadeFocus;
  final FocusNode? cvvFocus;
  final FocusNode? nomeFocus;
  final FocusNode? cpfFocus;
  final FocusNode? emailFocus;
  final Function(String)? cartaoOnSubmitted;
  final Function(String)? validadeOnSubmitted;
  final Function(String)? cvvOnSubmitted;
  final Function(String)? nomeOnSubmitted;
  final Function(String)? cpfOnSubmitted;
  final Function(String)? emailOnSubmitted;
  const CardPaymentPage({
    super.key,
    this.onPagar,
    this.onChanged,
    required this.iconeCartao,
    this.cartaoController,
    this.validadeController,
    this.cvvController,
    this.nomeController,
    this.cpfController,
    this.emailController,
    this.cartaoFocus,
    this.validadeFocus,
    this.cvvFocus,
    this.nomeFocus,
    this.cpfFocus,
    this.emailFocus,
    this.cartaoOnSubmitted,
    this.validadeOnSubmitted,
    this.cvvOnSubmitted,
    this.nomeOnSubmitted,
    this.cpfOnSubmitted,
    this.emailOnSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Pagamento com Cartão",
            style: context.cusotomFontes.textBold.copyWith(
              color: ColorsConstants.appBarColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),

          // Número do cartão
          SizedBox(
            width: 580,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberInputFormatter(),
              ],
              controller: cartaoController,
              focusNode: cartaoFocus,
              onSubmitted: cartaoOnSubmitted,
              maxLength: 19,
              cursorColor: ColorsConstants.appBarColor,
              cursorWidth: 3,
              cursorHeight: 18,
              decoration: InputDecoration(
                labelText: "Número do cartão",
                hintText: "0000 0000 0000 0000",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                counterText: "",

                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 2,
                  ), // coloque o valor que quiser
                  child: iconeCartao == 'visa'
                      ? Image.asset(LogosCartoes.visa, width: 40)
                      : iconeCartao == 'mastercard'
                      ? Image.asset(LogosCartoes.mastercard, width: 40)
                      : Icon(Icons.credit_card),
                ),

                prefixIconConstraints: BoxConstraints(maxWidth: 30),
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Validade
              SizedBox(
                width: 285,
                child: TextField(
                  controller: validadeController,
                  focusNode: validadeFocus,
                  onSubmitted: validadeOnSubmitted,
                  cursorColor: ColorsConstants.appBarColor,
                  cursorWidth: 3,
                  cursorHeight: 18,
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardExpiryInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Validade",
                    hintText: "MM/AA",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // CVV
              SizedBox(
                width: 285,
                child: TextField(
                  controller: cvvController,
                  focusNode: cvvFocus,
                  onSubmitted: cvvOnSubmitted,
                  cursorColor: ColorsConstants.appBarColor,
                  cursorWidth: 3,
                  cursorHeight: 18,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "CVV",
                    hintText: "123",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: "",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Nome do titular
          SizedBox(
            width: 580,
            child: TextField(
              controller: nomeController,
              focusNode: nomeFocus,
              onSubmitted: nomeOnSubmitted,
              cursorColor: ColorsConstants.appBarColor,
              cursorWidth: 3,
              cursorHeight: 18,
              decoration: InputDecoration(
                labelText: "Nome do titular",
                hintText: "Como está no cartão",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nome do titular
          SizedBox(
            width: 580,
            child: TextField(
              controller: emailController,
              focusNode: emailFocus,
              onSubmitted: emailOnSubmitted,
              cursorColor: ColorsConstants.appBarColor,
              cursorWidth: 3,
              cursorHeight: 18,
              decoration: InputDecoration(
                labelText: "E-mail do titular",
                hintText: "E-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nome do titular
          SizedBox(
            width: 580,
            child: TextField(
              controller: cpfController,
              focusNode: cpfFocus,
              onSubmitted: cpfOnSubmitted,
              cursorColor: ColorsConstants.appBarColor,
              cursorWidth: 3,
              cursorHeight: 18,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: "CPF do titular",
                hintText: "CPF",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Botão de pagar
          SizedBox(
            width: 580,
            child: ElevatedButton(
              onPressed: onPagar,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Pagar agora",
                style: context.cusotomFontes.textBold.copyWith(
                  color: ColorsConstants.primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var numbersOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final buffer = StringBuffer();

    for (int i = 0; i < numbersOnly.length; i++) {
      buffer.write(numbersOnly[i]);
      if ((i + 1) % 4 == 0 && i + 1 != numbersOnly.length) {
        buffer.write(' ');
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String cpf = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (cpf.length > 11) {
      cpf = cpf.substring(0, 11);
    }

    String formatted = '';

    if (cpf.length >= 1) {
      formatted = cpf.substring(0, 1);
    }
    if (cpf.length >= 2) {
      formatted = cpf.substring(0, 2);
    }
    if (cpf.length >= 3) {
      formatted = cpf.substring(0, 3);
    }
    if (cpf.length >= 4) {
      formatted = '${cpf.substring(0, 3)}.${cpf.substring(3, 4)}';
    }
    if (cpf.length >= 5) {
      formatted = '${cpf.substring(0, 3)}.${cpf.substring(3, 5)}';
    }
    if (cpf.length >= 6) {
      formatted = '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}';
    }
    if (cpf.length >= 7) {
      formatted =
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 7)}';
    }
    if (cpf.length >= 8) {
      formatted =
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 8)}';
    }
    if (cpf.length >= 9) {
      formatted =
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}';
    }
    if (cpf.length >= 10) {
      formatted =
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 10)}';
    }
    if (cpf.length == 11) {
      formatted =
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
