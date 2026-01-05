import 'package:flutter/material.dart';
import 'package:servicespro/src/pages/employee_pages/employee_home_screen.dart';
import 'package:servicespro/src/pages/employee_pages/employee_pedidos_screen.dart';
import 'package:servicespro/src/pages/employee_pages/employee_servicos_screen.dart';
import 'package:servicespro/src/pages/perfil_screen.dart';

class EmployeePrincipalScreen extends StatefulWidget {
  const EmployeePrincipalScreen({super.key});

  @override
  State<EmployeePrincipalScreen> createState() =>
      _EmployeePrincipalScreenState();
}

class _EmployeePrincipalScreenState extends State<EmployeePrincipalScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        EmployeeHomeScreen(),
        EmployeeServicosScreen(),
        EmployeePedidosScreen(),
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
