import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorsConstants.fundoCard),
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Dashboard',
              style: context.fontesLetras.textThin.copyWith(
                fontSize: 20,
                color: ColorsConstants.fundoCard,
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(ImageConstants.dashboard, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // child: GridView.count(
        //   crossAxisCount: 1, // 2 cards por linha
        //   crossAxisSpacing: 16,
        //   mainAxisSpacing: 16,
        //   children: const [
        //     DashboardCard(title: 'Usuários', value: '150'),
        //     DashboardCard(title: 'Pedidos', value: '75'),
        //     DashboardCard(title: 'Faturamento', value: 'R\$ 12.000'),
        //     DashboardCard(title: 'Produtos', value: '320'),
        //   ],
        // ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: DashboardPage()));
}
