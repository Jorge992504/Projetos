import 'package:delivery/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/models/payment_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class PaymentTypesField extends StatelessWidget {
  final String title;
  final List<PaymentTypesModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String valueSelect;
  const PaymentTypesField({
    super.key,
    required this.title,
    required this.paymentTypes,
    required this.valueChanged,
    required this.valid,
    required this.valueSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyles.textRegular.copyWith(
              fontSize: 16,
            ),
          ),
          SmartSelect<String>.single(
            title: '',
            selectedValue: valueSelect,
            modalType: S2ModalType.bottomSheet,
            onChange: (select) {
              valueChanged(int.parse(select.value));
            },
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? '',
                            style: context.textStyles.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: const Divider(
                        color: Colors.red,
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: Text(
                        'Selecione uma forma de pagamento',
                        style: context.textStyles.textRegular
                            .copyWith(fontSize: 13, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom<String, Map<String, String>>(
              source: paymentTypes
                  .map((p) => {
                        'value': p.id.toString(),
                        'title': p.nome,
                      })
                  .toList(),
              // [ lista fixa de elementos
              //   {'value': 'VA', 'title': 'Vale Alimentação'},
              //   {'value': 'VR', 'title': 'Vale Refeição'},
              //   {'value': 'CC', 'title': 'Cartão de Crédito'},
              // ],
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false, //filtro
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
