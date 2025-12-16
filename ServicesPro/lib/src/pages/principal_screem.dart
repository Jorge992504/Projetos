import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/src/pages/pedidos_screen.dart';
import 'package:servicespro/src/pages/perfil_screen.dart';
import 'package:servicespro/src/pages/servicos_screen.dart';
import 'package:servicespro/src/pages/splash_screen.dart';
import 'package:servicespro/src/pages/home_screen.dart';

class PrincipalScreem extends StatefulWidget {
  const PrincipalScreem({super.key});

  @override
  State<PrincipalScreem> createState() => _PrincipalScreemState();
}

class _PrincipalScreemState extends State<PrincipalScreem> {
  int _currentIndex = 0;
  bool isServicos = false;

  final List<Widget> pages = [
    PrincipalScreem(),
    SplashScreen(),
    ServicosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 1
            ? Text(
                "Serviços disponíveis",
                style: context.cusotomFontes.medium.copyWith(
                  color: isDark
                      ? ColorsConstants.primaryColor
                      : ColorsConstants.letrasColor,
                ),
              )
            : _currentIndex == 2
            ? Text(
                "Pedidos realizados",
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
              label: 'Serviços',
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
        HomeScreen(),
        ServicosScreen(),

        PedidosScreen(),
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
