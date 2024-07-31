import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/providers/auth.dart';
import 'package:version_1/screens/children/child/games/gameHistory.dart';
import 'package:version_1/screens/children/child/games/memoryGame/memoryGame.dart';
import 'package:version_1/screens/articles/article_content.dart';
import 'package:version_1/screens/auth/authScreenAnimated.dart';
import 'package:version_1/screens/auth/logout.dart';
import 'package:version_1/screens/children/addChild.dart';
import 'package:version_1/screens/children/addChildSex.dart';
import 'package:version_1/screens/children/child/article/childArticlesTab.dart';
import 'package:version_1/screens/children/child/childHome.dart';
import 'package:version_1/screens/children/child/childProfile/childProfile.dart';
import 'package:version_1/screens/children/child/events/addEvent.dart';
import 'package:version_1/screens/children/child/events/addEventsDetails.dart';
import 'package:version_1/screens/children/child/events/eventDetails.dart';
import 'package:version_1/screens/children/child/events/events.dart';
import 'package:version_1/screens/children/child/games/DragableShape.dart';
import 'package:version_1/screens/children/child/games/gamesHome.dart';
import 'package:version_1/screens/children/child/games/memoryGame/gameHome.dart';
import 'package:version_1/screens/children/child/games/memoryGame/test.dart';
import 'package:version_1/screens/children/child/video/playvideo.dart';
import 'package:version_1/screens/doctors/doctor_info.dart';
import 'package:version_1/screens/navbar.dart';
import 'package:version_1/screens/profile/profileScreen.dart';
import 'package:version_1/screens/splash.dart';
import 'screens/children/child/games/mathGame/mathGame.dart';

void main() {
  runApp(const MyApp());
}

const url = "192.168.16.193:8000";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: auth()),
      ],
      child: Consumer<auth>(
        // ignore: avoid_types_as_parameter_names
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(98, 55, 117, 1)),
            fontFamily: 'Amiri',
            primaryColorLight: const Color.fromRGBO(98, 55, 117, 1),
            hintColor: const Color.fromRGBO(200, 162, 200, 1),
            primaryColorDark: const Color.fromRGBO(253, 252, 214, 1),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            Splash.routname: (context) => const Splash(),
            authScreenAnimated.routname: (context) =>
                const authScreenAnimated(),
            navBar.routname: (context) => navBar(),
            article_content.routname: (context) => article_content(),
            doctor_info.routname: (context) => const doctor_info(),
            profileScreen.routname: (context) => profileScreen(),
            logout.routname: (context) => const logout(),
            addChildSex.routname: (context) => const addChildSex(),
            addChild.routname: (context) => addChild(),
            childHome.routname: (context) => childHome(),
            events.routname: (context) => events(),
            childArticles.routname: (context) => childArticles(),
            childProfile.routname: (context) => const childProfile(),
            addEvent.routname: (context) => addEvent(),
            eventDetails.routname: (context) => eventDetails(),
            addEventDetails.routname: (context) => const addEventDetails(),
            playvideo.routname: (context) => playvideo(),
            DragableShape.routname: (context) => const DragableShape(),
            MathGame.routname: (context) => MathGame(),
            gamesHome.routname: (context) => gamesHome(),
            gameHome.routname: (context) => const gameHome(),
            test.routname: (context) => const test(),
            gameHistory.routname: (context) => const gameHistory(),
          },
          home: auth.isAuth
              ? navBar()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, AsyncSnapshot authsnapshot) =>
                      authsnapshot.connectionState == ConnectionState.waiting
                          ? const Splash()
                          : const authScreenAnimated()),
        ),
      ),
    );
  }
}
