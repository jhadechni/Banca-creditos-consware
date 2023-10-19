import 'package:flutter/material.dart';
import 'package:prueba_tecnica_consware/app/util/colors.dart';
import 'package:prueba_tecnica_consware/presentation/pages/historial/historial_page.dart';
import 'package:prueba_tecnica_consware/presentation/pages/home/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home_sharp,
              color: Palette.kPrimaryColor,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.cases_sharp,
              color: Palette.kPrimaryColor,
            ),
            icon: Icon(Icons.cases_sharp),
            label: 'Historial de créditos',
          )
        ],
      ),
      body: <Widget>[
        const SafeArea(child: HomePage()),
        const SafeArea(child: HistorialPage())
      ][currentPageIndex],
    );
  }
}
