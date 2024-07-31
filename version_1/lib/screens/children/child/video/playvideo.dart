import 'package:flutter/material.dart';
import 'package:version_1/screens/children/child/childDrawer.dart';
import 'package:version_1/screens/children/child/video/allvideos.dart';
import 'package:version_1/screens/children/child/video/favvideos.dart';

class playvideo extends StatefulWidget {
  playvideo();
  static const routname = 'videoplay';

  @override
  State<playvideo> createState() => _playvideoState();
}

class _playvideoState extends State<playvideo> {
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
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
                "الفيديوهات",
                style: TextStyle(
                    fontSize: screen.width * 0.06,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            endDrawer: childDrawerPage(),
            body: TabBarView(children: [allVideos(), favVideos()])));
  }
}
