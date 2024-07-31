import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'memoryGame.dart';
import 'MatchedAnimation.dart';
import 'flipAnimation.dart';
import '../../../../../model/word.dart';

class WordTile extends StatelessWidget {
  const WordTile({
    required this.index,
    required this.word,
    Key? key,
  }) : super(key: key);

  final int index;
  final Word word;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Consumer<GameManager>(
      builder: (_, notifier, __) {
        bool animate = checkAnimationRun(notifier);

        return GestureDetector(
          onTap: () {
            if (!notifier.ignoreTaps &&
                !notifier.answeredWords.contains(index) &&
                !notifier.tappedWords.containsKey(index)) {
              notifier.tileTapped(index: index, word: word);
            }
          },
          child: FlipAnimation(
            delay: notifier.reverseFlip ? 500 : 0,
            reverse: notifier.reverseFlip,
            animationCompleted: (isForward) {
              notifier.onAnimationCompleted(isForward: isForward);
            },
            animate: animate,
            word: MatchedAnimation(
              numberOfWordsAnswered: notifier.answeredWords.length,
              animate: notifier.answeredWords.contains(index),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: word.DisplayText
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Text(
                                word.text,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screen.width * 0.08,
                                    fontWeight: FontWeight.bold),
                              )))
                      : SvgPicture.asset(word.url)),
            ),
          ),
        );
      },
    );
  }

  bool checkAnimationRun(GameManager notifier) {
    bool animate = false;

    if (notifier.canFlip) {
      if (notifier.tappedWords.isNotEmpty &&
          notifier.tappedWords.keys.last == index) {
        animate = true;
      }
      if (notifier.reverseFlip && !notifier.answeredWords.contains(index)) {
        animate = true;
      }
    }
    return animate;
  }
}
