import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:faltou_nada/app/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<ProductModel> sugestoes;
  final FocusNode? focusNode;
  final Function()? onPressed;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool empty;
  final HomeController homeController;
  const HomeTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.sugestoes,
    this.onPressed,
    this.onChanged,
    this.onTap,
    this.empty = false,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.percentWidth(1),
          height: 35,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            cursorHeight: 16,
            cursorWidth: 2, // Mais fina
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              labelText: 'Pesquisar produtos',
              labelStyle: context.fontesLetras.textLight.copyWith(
                fontSize: 16,
                color: ColorsConstants.black,
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  // controller!.text.isNotEmpty &&
                  (sugestoes.isEmpty)
                      ? Icons.search_outlined
                      : Icons.add_shopping_cart_rounded,
                  size: 20,
                  color: ColorsConstants.appBar,
                ),
              ),
            ),
            onChanged: onChanged,
            onTap: onTap,
            onSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        Visibility(
          visible: empty ? true : false,
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: sugestoes.length,
              itemBuilder: (context, index) {
                final product = sugestoes[index];
                return ListTile(
                  leading: Image.network(
                    product.foto,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    product.nome,
                    style: context.fontesLetras.textRegular.copyWith(
                      fontSize: 14,
                      color: ColorsConstants.appBar,
                    ),
                  ),
                  onTap: () {
                    onTapList(product.id);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void onTapList(int productId) async {
    bool result = await homeController.saveProductToUser(productId);
    if (result) {
      await homeController.refresh();
    }
  }
}
