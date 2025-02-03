import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class DateFormFieldController extends TextEditingController {
  DateTime data = DateTime.now();
}

class DateFormField extends StatefulWidget {
  final DateFormFieldController dateController;
  const DateFormField({super.key, required this.dateController});

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: dataController,
        validator: Validatorless.required('Data de nascimento obrigatoria'),
        readOnly: true,
        onChanged: (val) => setState(() {
          DateTime data = DateFormat("dd/MM/yyyy").parse(val);
          widget.dateController.data = data;
          widget.dateController.text = val;
        }),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), // Define a data inicial
            firstDate: DateTime(1900), // Define a data mínima
            lastDate: DateTime(2101), // Define a data máxima
          );
          if (picked != null && picked != DateTime.now()) {
            setState(() {
              widget.dateController.data = picked;

              widget.dateController.text =
                  DateFormat('dd/MM/yyyy').format(picked);
            });
          }
        },
        decoration: InputDecoration(
          labelText: 'Nascimento',
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
          ),
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: 8,
            color: Colors.transparent,
          ),
        ),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ), // Cor do texto digitado
      ),
    );
  }
}
