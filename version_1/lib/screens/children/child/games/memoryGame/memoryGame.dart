import 'package:flutter/material.dart';

import '../../../../../model/word.dart';

class GameManager extends ChangeNotifier {
  Map<int, Word> tappedWords = {};
  bool canFlip = false, reverseFlip = false, ignoreTaps = false;
  bool roundComplete = false;
  List<int> answeredWords = [];

  tileTapped({required int index, required Word word}) {
    ignoreTaps = true;
    if (tappedWords.length <= 1) {
      tappedWords.addEntries([MapEntry(index, word)]);
      canFlip = true;
    } else {
      canFlip = false;
    }

    notifyListeners();
  }

  onAnimationCompleted({required bool isForward}) async {
    if (tappedWords.length == 2) {
      if (isForward) {
        if (tappedWords.entries.elementAt(0).value.text ==
            tappedWords.entries.elementAt(1).value.text) {
          answeredWords.addAll(tappedWords.keys);
          if (answeredWords.length == 8) {
            roundComplete = true;
          }
          tappedWords.clear();
          canFlip = true;
          ignoreTaps = false;
        } else {
          reverseFlip = true;
        }
      } else {
        reverseFlip = false;
        tappedWords.clear();
        ignoreTaps = false;
      }
    } else {
      canFlip = false;
      ignoreTaps = false;
    }
    print(reverseFlip);
    notifyListeners();
  }
}
