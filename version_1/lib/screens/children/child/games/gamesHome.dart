import 'package:flutter/material.dart';
import 'package:version_1/model/gamesList.dart';
import 'package:version_1/screens/children/child/games/gameHistory.dart';

class gamesHome extends StatelessWidget {
  static const routname = 'gamesHome';

  gamesHome({super.key});
  var games = gamesList;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "الألعاب",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screen.height,
            width: screen.width,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Container(
                height: screen.height,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(games[index].route),
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screen.width,
                              height: screen.height * 0.22,
                              child: Image.asset(
                                games[index].pic,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: screen.height * 0.07,
                              width: screen.width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.7),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${games[index].id}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screen.width * 0.06,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: screen.height * 0.03,
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: "his",
                                          padding: EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "تاريخ اللعبة",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.history,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      onSelected: (value) =>
                                          Navigator.of(context).pushNamed(
                                              gameHistory.routname,
                                              arguments: {
                                            'gameName':
                                                games[index].id.toString()
                                          }),
                                    ),
                                  ]),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
