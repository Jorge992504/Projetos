import 'package:barber/src/core/ui/constant/color_constants.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  const HomeEmployeeTile({super.key});
  final imageNetwork = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorConstants.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage('url'),
                  false => const AssetImage(ImageConstante.avatar),
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nome e sobrenome',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        onPressed: () {},
                        child: const Text('Agendar')),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Ver agenda')),
                    const Icon(
                      Icons.mode_edit_outline,
                      size: 12,
                      color: ColorConstants.brow,
                    ),
                    const Icon(
                      Icons.delete_forever_outlined,
                      size: 16,
                      color: ColorConstants.brow,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
