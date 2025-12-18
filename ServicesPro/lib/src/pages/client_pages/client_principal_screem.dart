import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/src/pages/client_pages/client_criar_pedido_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_pedidos_screen.dart';
import 'package:servicespro/src/pages/perfil_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_home_screen.dart';

class ClientPrincipalScreem extends StatefulWidget {
  const ClientPrincipalScreem({super.key});

  @override
  State<ClientPrincipalScreem> createState() => _ClientPrincipalScreemState();
}

class _ClientPrincipalScreemState extends State<ClientPrincipalScreem> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 1
            ? Text(
                "Publicar serviço",
                style: context.cusotomFontes.medium.copyWith(
                  color: isDark
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                ),
              )
            : _currentIndex == 2
            ? Text(
                "Meus Pedidos",
                style: context.cusotomFontes.medium.copyWith(
                  color: isDark
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                ),
              )
            : null,
        actions: [
          IconButton(
            splashRadius: 5,

            onPressed: () {},
            icon: CircleAvatar(child: Icon(Icons.notifications_none, size: 25)),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: onTap,

          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, size: 20),
              selectedIcon: Icon(Icons.home, size: 20),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.work_outline, size: 20),
              selectedIcon: Icon(Icons.work, size: 20),
              label: 'Serviço',
            ),

            NavigationDestination(
              icon: Icon(Icons.receipt_outlined, size: 20),
              selectedIcon: Icon(Icons.receipt, size: 20),
              label: 'Pedidos',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, size: 20),
              selectedIcon: Icon(Icons.person, size: 20),
              label: 'Perfil',
            ),
          ],
        ),
      ),
      body: <Widget>[
        ClientHomeScreen(),
        ClientCriarPedidoScreen(),
        ClientPedidosScreen(),
        PerfilScreen(),
      ][_currentIndex],
    );
  }

  void onTap(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
