import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/core/ui/constant/color_constants.dart';
import 'package:barber/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;
  const HomeHeader({super.key}) : showFilter = true;
  const HomeHeader.withouFilter({super.key}) : showFilter = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMeProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              32,
            ),
            bottomRight: Radius.circular(
              32,
            ),
          ),
          image: DecorationImage(
            image: AssetImage(
              ImageConstante.backgroundImage,
            ),
            fit: BoxFit.cover,
            opacity: 0.5,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbershop.maybeWhen(
            data: (barbershopData) {
              return Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffbdbdbd),
                    child: SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      barbershopData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: Text(
                      'editar',
                      style: TextStyle(
                        color: ColorConstants.brow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      // BarbershopIcons.exit,
                      Icons.exit_to_app_rounded,
                      color: ColorConstants.brow,
                      size: 32,
                    ),
                  ),
                ],
              );
            },
            orElse: () {
              return const Center(
                child: BarbershopLoader(),
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem-vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um cliente',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Buscar colaborador',
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    // BarbershopIcons.search,
                    Icons.search,
                    color: ColorConstants.brow,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
