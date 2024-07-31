import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/games/memoryGame/memoryGame.dart';
import 'package:version_1/screens/children/child/games/memoryGame/test.dart';
import '../../../../../model/sourceWords.dart';
import '../popUp.dart';
import '../../../../../model/word.dart';
import 'wordTile.dart';

class gameHome extends StatefulWidget {
  static const routname = 'memoryHome';

  const gameHome();

  @override
  State<gameHome> createState() => _gameHomeState();
}

class _gameHomeState extends State<gameHome> {
  var firstTime = DateTime.now();
  var lastTime;
  List<Word> _gridWords = [];
  @override
  void initState() {
    _setUp();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "لعبة الذاكرة",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Selector<GameManager, bool>(
          selector: (_, GameManager) => GameManager.roundComplete,
          builder: (_, roundComplet, __) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) async {
                if (roundComplet) {
                  await showDialog(
                      barrierColor: Colors.transparent,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => ReplayPopUp(
                          test.routname, firstTime, DateTime.now()));
                }
              },
            );

            return SafeArea(
              child: Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      left: screen.width * 0.1, right: screen.width * .1),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: screen.width * 0.38),
                  itemBuilder: (context, index) {
                    print(index);
                    print(_gridWords[index].text);
                    return WordTile(index: index, word: _gridWords[index]);
                  },
                  itemCount: 8,
                ),
              ),
            );
          }),
    );
  }

  _setUp() {
    List<Word> list = sourceWords;
    list.shuffle();
    for (int i = 0; i < 4; i++) {
      _gridWords.add(list[i]);
      _gridWords
          .add(Word(text: list[i].text, url: list[i].url, DisplayText: true));
    }
    _gridWords.shuffle();
  }
}
