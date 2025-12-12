// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';

import 'package:servicespro/src/pages/servicos_screen.dart';
import 'package:servicespro/src/pages/splash_screen.dart';
import 'package:servicespro/src/widgets/home_screen/custom_screen.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  int _currentIndex = 0;
  bool isServicos = false;

  final List<Widget> pages = [HomeScreem(), SplashScreen(), ServicosScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            splashRadius: 5,

            onPressed: () {},
            icon: Icon(Icons.notifications_none, size: 25),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: onTap,

          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.work_outline),
              selectedIcon: Icon(Icons.work),
              label: 'Serviços',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
      body: isServicos == false ? CustomScreen() : ServicosScreen(),
    );
  }

  void onTap(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 0) {
      setState(() {
        isServicos = false;
      });
    }

    if (_currentIndex == 1) {
      setState(() {
        isServicos = true;
      });
    }
    if (_currentIndex == 2) Navigator.of(context).pushNamed(Rotas.splash);
    log('==before=index======> $index');
    log('==before=_currentIndex======> $_currentIndex');
  }
}
