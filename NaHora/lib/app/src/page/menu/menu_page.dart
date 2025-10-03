import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/base/base_state.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/custom_images.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';
import 'package:nahora/app/core/ui/style/size_extension.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/page/menu/menu_controllers.dart';
import 'package:nahora/app/src/widgets/custom_buttons_add_remove.dart';
import 'package:nahora/app/src/widgets/custom_item.dart';

//**
// 1 => SALDAS
// 2 => CARNES
// 3 => PIZZAS
// 4 => SUSHI
// 5 => REFRIGERANTES
// 6 => HAMBURGUER
// */

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends BaseState<MenuPage, MenuControllers> {
  int menu = 0;
  List<SacolaModelRequest> sacola = [];
  String novaSacola = 'teste para saber se devolve';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        menu = arguments['menu'];
        sacola = arguments['sacola'];
      });

      controller.buscaProdutosEspecificos(menu, sacola);
      controller.buscaPromocoesEspecificas(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: ColorsConstants.buttonColor,
              onTap: () {
                Navigator.of(context).pop(novaSacola);
              },
              child: Image.asset(
                ImageConstants.back,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          menu == 1
              ? 'Veganos'
              : menu == 2
              ? 'Carnes'
              : menu == 3
              ? 'Pizzas'
              : menu == 4
              ? 'Sushi'
              : menu == 5
              ? 'Refrigerantes'
              : 'Hambuerguer',
          style: context.cusotomFontes.textExtraBold.copyWith(
            color: ColorsConstants.letrasColor,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: menu == 1
            ? ColorsConstants.appBarVeganColor
            : menu == 2
            ? ColorsConstants.appBarMeatColor
            : ColorsConstants.appBarColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: context.percentHeight(0.4),
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomItem(
                          heightImage: 50,
                          widthImage: 50,
                          childImage: Image.asset(
                            menu == 1
                                ? ImageConstants.meat
                                : menu == 2
                                ? ImageConstants.salad
                                : menu == 3
                                ? ImageConstants.sushi
                                : menu == 4
                                ? ImageConstants.refri
                                : menu == 5
                                ? ImageConstants.hamburguer
                                : ImageConstants.pizza,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CustomButtonsAddRemove(
                          childAdd: Image.asset(
                            menu == 1
                                ? ImageConstants.addVegan
                                : menu == 2
                                ? ImageConstants.add
                                : ImageConstants.addGeral,
                            width: 23,
                            height: 23,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              "Promoções do dia.",
              style: context.cusotomFontes.textExtraBold.copyWith(
                fontSize: 20,
                color: ColorsConstants.buttonColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: context.percentHeight(0.18),
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomItem(
                          heightImage: 50,
                          widthImage: 50,
                          childImage: Image.asset(
                            menu == 1
                                ? ImageConstants.meat
                                : menu == 2
                                ? ImageConstants.salad
                                : menu == 3
                                ? ImageConstants.sushi
                                : menu == 4
                                ? ImageConstants.refri
                                : menu == 5
                                ? ImageConstants.hamburguer
                                : ImageConstants.pizza,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CustomButtonsAddRemove(
                          childAdd: Image.asset(
                            menu == 1
                                ? ImageConstants.add
                                : menu == 2
                                ? ImageConstants.addVegan
                                : ImageConstants.addGeral,
                            width: 23,
                            height: 23,
                            fit: BoxFit.cover,
                          ),
                          onTapAdd: () {},
                          onTapRemove: () {},
                          labelCount: 'counts[index].toString()',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
