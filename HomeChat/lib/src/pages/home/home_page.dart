import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/home/home_vm.dart';
import 'package:homechat/src/pages/home/widgets/friends.dart';

import 'package:homechat/src/pages/home/widgets/search.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

int currentPageIndex = 0;

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue[100],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.blue,
            ),
            selectedIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              // Icons.person_2_outlined,
              Icons.people_outline,
              color: Colors.blue,
            ),
            selectedIcon: Icon(
              Icons.people,
              color: Colors.blue,
            ),
            label: 'Amigos',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_search_outlined,
              color: Colors.blue,
            ),
            selectedIcon: Icon(
              Icons.person_search,
              color: Colors.blue,
            ),
            label: 'Pesquisar',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(left: 15, top: 28),
          child: IconButton(
            onPressed: () {
              ref.read(homeVmProvider.notifier).logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
            },
            icon: const Icon(
              Icons.logout_sharp,
              size: 30,
              color: Colors.blue,
            ),
          ),
        ),
        const Friends(),
        const Search(),
      ][currentPageIndex],
    );
  }
}
