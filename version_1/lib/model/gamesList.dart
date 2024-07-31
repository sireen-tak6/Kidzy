import 'package:version_1/screens/children/child/games/memoryGame/test.dart';
import '../screens/children/child/games/DragableShape.dart';
import '../screens/children/child/games/mathGame/mathGame.dart';

// ignore: camel_case_types
class game {
  final String id;
  final String route;
  final String pic;
  game(this.id, this.route, this.pic);
}

List<game> gamesList = [
  game("لعبة الأشكال", DragableShape.routname, "shapes.jpg"),
  game("لعبة الحسابات", MathGame.routname, "math.jpg"),
  game("لعبة الذاكرة", test.routname, "match.jpg"),
];
