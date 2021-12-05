import 'package:flutter/material.dart';
import 'package:tp2_miaged/user/panier.dart';
import 'package:tp2_miaged/user/profil.dart';

import '../acheter/acheter.dart';
import '../globals.dart' as globals;

void home() => runApp(const HomeView());

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AcheterView(categ: 'tout'),
    PanierView(),
    ProfilView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      home: _selectedIndex == 0
          ? DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    AcheterView(categ: 'tout'),
                    AcheterView(categ: 'haut'),
                    AcheterView(categ: 'bas'),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.add_shopping_cart_outlined),
                      label: 'Acheter',
                    ),
                    BottomNavigationBarItem(
                      icon: Text(
                        globals.currentUser.panier.length.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      label: 'Panier',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                      label: 'Profil',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: const Color(0xFF02837A),
                  onTap: _onItemTapped,
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/MIAGED_Logo.png'),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.add_shopping_cart_outlined),
                    label: 'Acheter',
                  ),
                  BottomNavigationBarItem(
                    icon: Text(
                      globals.currentUser.panier.length.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    label: 'Panier',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'Profil',
                  ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF02837A),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
