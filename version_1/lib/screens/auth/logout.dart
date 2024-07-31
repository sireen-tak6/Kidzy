import 'package:flutter/material.dart';

import '../Drawer.dart';

class logout extends StatelessWidget {
  static const routname = 'logout';

  const logout({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Image.asset(
          "Kidzy2.png",
          width: screen.width * 0.2,
        ),
      ),
      endDrawer: DrawerPage(),
      body: Text("hi9"),
    );
  }
}
