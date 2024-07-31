import 'package:flutter/material.dart';
import 'package:version_1/screens/articles/articleScreen.dart';

import 'favarticleScreen.dart';

class tab extends StatefulWidget {
  @override
  State<tab> createState() => _tabState();
}

class _tabState extends State<tab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
            tabs: [
              Tab(
                text: "fav",
              ),
              Tab(
                text: "all",
              )
            ],
          )),
          body: TabBarView(
            children: [fav(), articleScreen()],
          ),
        ));
  }
}
