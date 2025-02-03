import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ishopping/src/models/products_model.dart';
import 'package:ishopping/src/pages/home/home_vm.dart';
import 'package:ishopping/src/pages/home/selected_product/selected_product_vm.dart';
import 'package:ishopping/src/pages/home/vm/list_products_vm.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';

class HomeSearch extends ConsumerStatefulWidget {
  const HomeSearch({
    super.key,
  });

  @override
  ConsumerState<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends ConsumerState<HomeSearch> {
  //
  List<ProductsModel> suggestions = [];
  List<ProductsModel> allProducts = [];
  final searchEC = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isFocused = false;

  //

  @override
  void initState() {
    super.initState();
    fetchAllProducts();

    // Listener para detectar o foco no campo
    searchFocusNode.addListener(() {
      setState(() {
        isFocused = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchEC.dispose();
    super.dispose();
  }

  // Busca inicial dos produtos
  Future<void> fetchAllProducts() async {
    final homeState = await ref.read(homeVmProvider.future);
    setState(() {
      allProducts = homeState.products.toList();
    });
  }

  // Filtra a lista de sugestões
  void fetchSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        suggestions = [];
        setState(() {});
      } else {
        suggestions = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedProduct = ref.watch(selectedProductVmProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            controller: searchEC,
            focusNode: searchFocusNode,
            decoration: InputDecoration(
              labelText: 'Pesquisar produtos',
              labelStyle: const TextStyle(color: ColorsConstants.label),
              fillColor: ColorsConstants.fundoLabel,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorsConstants.fundoLabel),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorsConstants.fundoLabel),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: ColorsConstants.label,
              suffixIcon: IconButton(
                onPressed: () async {
                  await selectedProduct.postNewProduct(searchEC.text);
                  ref.refresh(listProductsProvider);
                  ref.refresh(selectedProductVmProvider);
                  isFocused = false;
                  searchFocusNode.unfocus();
                },
                icon: Icon(
                  Icons.add_shopping_cart_rounded,
                  color: (searchEC.text.isEmpty || suggestions.isNotEmpty) ||
                          !isFocused
                      ? ColorsConstants.fundoLabel
                      : ColorsConstants.label,
                ),
              ),
            ),
            style: context.fontes.textMedium
                .copyWith(color: ColorsConstants.label),
            onChanged: (value) {
              fetchSuggestions(value);
            },
          ),
        ),
        const SizedBox(height: 10),
        if (isFocused && suggestions.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final product = suggestions[index];
                return ListTile(
                  leading: Image.network(
                    product.photo,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    suggestions[index].name,
                    style: context.fontes.textRegular
                        .copyWith(color: ColorsConstants.label),
                  ),
                  onTap: () async {
                    final id = suggestions[index].id;
                    await selectedProduct.postProduct(id);
                    // searchEC.text = suggestions[index].name;
                    // suggestions = [];
                    isFocused = false;
                    searchFocusNode.unfocus();
                    //atualizar tela
                    ref.refresh(listProductsProvider);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
