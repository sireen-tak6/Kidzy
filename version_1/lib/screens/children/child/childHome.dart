import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:version_1/providers/auth.dart';
import 'package:version_1/screens/children/child/games/gamesHome.dart';
import 'package:version_1/screens/children/child/video/playvideo.dart';
import 'article/childArticlesTab.dart';
import 'childDrawer.dart';
import 'childHomeCard.dart';
import 'events/events.dart';

// ignore: camel_case_types, must_be_immutable
class childHome extends StatelessWidget {
  static const routname = 'childHome';
  const childHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var _id = Provider.of<auth>(context).childid;
    var _name = Provider.of<auth>(context).childname;
    var _gender = Provider.of<auth>(context).childgender;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          _name.toString(),
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      endDrawer: childDrawerPage(),
      body: Stack(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
              height: screen.height,
              width: screen.width,
              child:
                  SvgPicture.asset("assets/background.svg", fit: BoxFit.cover)),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: screen.width,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  childHomeCard(
                    'الألعاب',
                    'assets/games.svg',
                    () => Navigator.pushNamed(
                      context,
                      gamesHome.routname,
                    ),
                  ),
                  childHomeCard(
                    'الأحداث',
                    'assets/events.svg',
                    () => Navigator.pushNamed(
                      context,
                      events.routname,
                    ),
                  ),
                  childHomeCard(
                    'الفيديوهات',
                    'assets/videos.svg',
                    () => Navigator.pushNamed(
                      context,
                      playvideo.routname,
                    ),
                  ),
                  childHomeCard(
                    'المقالات',
                    'assets/articles.svg',
                    () => Navigator.pushNamed(
                      context,
                      childArticles.routname,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
