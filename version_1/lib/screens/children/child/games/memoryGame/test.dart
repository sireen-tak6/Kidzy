import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/games/memoryGame/gameHome.dart';

import 'memoryGame.dart';

class test extends StatelessWidget {
  static const routname = 'test';

  const test({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
        create: (_) => GameManager(), child: const gameHome());
  }
}
