import 'package:activovo/src/pages/home/home/home_vm.dart';
import 'package:activovo/src/providers/application_provider.dart';

import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/widgets/activovo_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeaderVip extends ConsumerWidget {
  const HomeHeaderVip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(getMeUserTypeProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorsConstants.greyFundoB,
        border: Border.all(
          color: ColorsConstants.greyAppBar,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        image: const DecorationImage(
          image: AssetImage(
            ImageConstante.activoco,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: result.maybeWhen(
        orElse: () {
          return const Center(
            child: ActivovoLoader(),
          );
        },
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 50,
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    ref.read(homeVmProvider.notifier).logout();
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: ColorsConstants.greyBotoes,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xffbdbdbd),
                    child: Image(
                      image: AssetImage(
                        ImageConstante.avatar,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      style: context.fontes.textSemiBold.copyWith(
                        fontSize: 16,
                        color: ColorsConstants.greyBotoes,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  data.email,
                  overflow: TextOverflow.ellipsis,
                  style: context.fontes.textSemiBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.greyBotoes,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'editar',
                        style: context.fontes.textRegular.copyWith(
                          fontSize: 16,
                          color: ColorsConstants.greyBotoes,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_note_sharp,
                      color: ColorsConstants.greyBotoes,
                      size: 24,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'VIP',
                    style: context.fontes.textExtraBold.copyWith(
                      fontSize: 16,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: Colors.yellowAccent,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
