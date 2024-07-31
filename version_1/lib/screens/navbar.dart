import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version_1/screens/Drawer.dart';
import 'package:version_1/screens/articles/articleScreen.dart';
import 'package:version_1/screens/articles/favarticleScreen.dart';
import 'package:version_1/screens/doctors/doctorsScreen.dart';

import 'children/childrenScreen.dart';

class navBar extends StatefulWidget {
  static const routname = 'navbar';

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  var _selectedIndex = 1;
  @override
  final _screens = [
    const childrenScreen(),
    const TabBarView(children: [articleScreen(), fav()]),
    const doctorsScreen()
  ];

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    Color backcolor = const Color.fromARGB(255, 219, 219, 219);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _selectedIndex == 1
            ? AppBar(
                bottom: TabBar(
                    labelStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                    labelColor: Theme.of(context).primaryColorDark,
                    unselectedLabelStyle: const TextStyle(fontSize: 18),
                    unselectedLabelColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.6),
                    indicatorColor: Theme.of(context).primaryColorDark,
                    tabs: const [
                      Tab(
                        child: Text(
                          "الكل",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "المفضلة",
                        ),
                      ),
                    ]),
                iconTheme:
                    IconThemeData(color: Theme.of(context).primaryColorDark),
                backgroundColor: Theme.of(context).primaryColorLight,
                centerTitle: true,
                title: Text(
                  "المقالات",
                  style: TextStyle(
                      fontSize: screen.width * 0.06,
                      color: Theme.of(context).primaryColorDark),
                ),
              )
            : AppBar(
                iconTheme:
                    IconThemeData(color: Theme.of(context).primaryColorDark),
                backgroundColor: Theme.of(context).primaryColorLight,
                centerTitle: true,
                title: Text(
                  _selectedIndex == 0 ? "الأطفال" : "الأطباء",
                  style: TextStyle(
                      fontSize: screen.width * 0.06,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
        endDrawer: const DrawerPage(),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).hintColor.withOpacity(0.5),
          color: Theme.of(context).primaryColorLight,
          index: _selectedIndex,
          items: [
            Container(
              padding: EdgeInsets.all(screen.width * 0.02),
              child: Icon(
                Icons.perm_contact_calendar,
                color: Theme.of(context).primaryColorDark,
                size: screen.height * 0.04,
              ),
            ),
            Container(
              padding: EdgeInsets.all(screen.width * 0.02),
              child: Icon(
                Icons.article,
                color: Theme.of(context).primaryColorDark,
                size: screen.height * 0.04,
              ),
            ),
            Container(
              padding: EdgeInsets.all(screen.width * 0.02),
              child: Icon(
                Icons.local_hospital,
                color: Theme.of(context).primaryColorDark,
                size: screen.height * 0.04,
              ),
            ),
          ],
          onTap: (index) => setState(
            () {
              _selectedIndex = index;
            },
          ),
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}
