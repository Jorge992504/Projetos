import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/home/home_state.dart';
import 'package:ishopping/src/pages/home/home_vm.dart';

import 'package:ishopping/src/pages/home/vm/list_products_vm.dart';
import 'package:ishopping/src/pages/home/widgets/home_products.dart';
import 'package:ishopping/src/pages/home/widgets/home_search.dart';

import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';
import 'package:ishopping/src/ui/helpers/messages.dart';

import 'package:ishopping/src/ui/image/image_constants.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String getInitials(String name) {
    if (name.isEmpty) {
      return '';
    }
    List<String> nameParts = name.trim().split(' ');
    String initials = '';

    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0];
      if (nameParts.length > 1) {
        initials += nameParts[1][0];
      }
    }
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(listProductsProvider);
    final home = ref.watch(listProductsProvider.notifier);
    final user = ref.watch(getMeProvider);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: context.screenMetWidth(0.8),
          height: 60,
          child: const Image(
            image: AssetImage(ImageConstants.title),
            fit: BoxFit.cover,
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: ColorsConstants.label,
              size: 28,
            ),
          );
        }),
      ),
      drawer: SafeArea(
        child: user.maybeWhen(orElse: () {
          return const Image(
            image: AssetImage(ImageConstants.loading),
          );
        }, data: (resultData) {
          return Drawer(
            backgroundColor: ColorsConstants.fundo,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: ColorsConstants.title),
                  accountName: Text(
                    resultData.name,
                    style: context.fontes.textMedium
                        .copyWith(fontSize: 14, color: ColorsConstants.label),
                  ),
                  accountEmail: Text(
                    resultData.email,
                    style: context.fontes.textMedium
                        .copyWith(fontSize: 14, color: ColorsConstants.label),
                  ),
                  currentAccountPicture: CircleAvatar(
                    // ignore: unrelated_type_equality_checks
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform
                            ? ColorsConstants.title
                            : ColorsConstants.fundo,
                    // backgroundImage: const AssetImage(ImageConstants.logo),
                    child: Text(
                      getInitials(resultData.name),
                      style: context.fontes.textExtraBold.copyWith(
                        fontSize: 28,
                        color: ColorsConstants.label,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      ref.read(homeVmProvider.notifier).logout();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.exit_to_app_rounded,
                            color: ColorsConstants.label),
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Sair',
                          style: context.fontes.textMedium
                              .copyWith(color: ColorsConstants.label),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const HomeSearch(),
          const SizedBox(
            height: 24,
          ),
          Flexible(
            child: SizedBox(
              height: context.screenMetHeight(0.7),
              child: result.when(
                data: (HomeState data) {
                  return CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 28,
                          childAspectRatio: 2 / 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (data.products.isEmpty) {
                              Messages.showInfo(
                                  'Não tem produtos na lista de compras',
                                  context);
                            }

                            final product = data.products[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  HomeProducts(
                                    label: product.name,
                                    onPressed: (value) async {
                                      await home.deleteProduct(value);
                                      ref.refresh(listProductsProvider);
                                    },
                                    id: product.id,
                                    photo: product.photo,
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: data.products.length,
                        ),
                      ),
                    ],
                  );
                },
                error: (error, s) {
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: AssetImage(ImageConstants.loading),
                      ),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: AssetImage(ImageConstants.loading),
                      ),
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


// SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 24,
//             ),
//             HomeSearch(),
//             SizedBox(
//               height: 24,
//             ),
//             //

//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: HomeProducts(),
//             ),
//           ],
//         ),
//       ),