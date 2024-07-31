import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:version_1/model/dragableShapeData.dart';
import 'package:flutter/services.dart';
import 'package:version_1/screens/children/child/games/popUp.dart';

class DragableShape extends StatefulWidget {
  static const routname = 'DragableShape';

  const DragableShape({super.key});

  @override
  State<DragableShape> createState() => _DragableShapeState();
}

class _DragableShapeState extends State<DragableShape> {
  List<bool> _isDone = [false, false, false, false, false, false];
  List<bool> _elementState = [false, false, false, false, false, false];
  final List<int> _isDisplayed = [];
  final List<int> _ter = [];
  int count = 0;
  late var firstTime;
  late var lastTime;
  void loop() {
    while (_isDisplayed.length != 3) {
      print(_isDisplayed.length);
      var s = Random().nextInt(6);
      if (!_isDisplayed.contains(s)) {
        setState(() {
          _isDisplayed.add(s);
        });
      }
    }
  }

  void loop2() {
    while (_ter.length != 3) {
      print(_ter.length);
      var s = Random().nextInt(3);
      if (!_ter.contains(s)) {
        setState(() {
          _ter.add(s);
        });
      }
    }
  }

  @override
  initState() {
    itemList.shuffle();
    super.initState();
    firstTime = DateTime.now();
    loop();
    loop2();
    print(_isDisplayed.length);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    double itemsize = screen.width * 0.2;
    double newsize = screen.width * 0.2;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "لعبة الأشكال",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  0, screen.height * 0.05, 0, screen.height * 0.05),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              width: screen.width,
              child: Center(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _isDisplayed.length,
                  itemBuilder: (context, lo) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DragTarget<itemdata>(
                        onWillAccept: (data) =>
                            data!.name == itemList[_isDisplayed[lo]].name,
                        onAccept: (data) {
                          setState(() {
                            _isDone[itemList.indexOf(data)] = true;
                            _elementState[itemList.indexOf(data)] = true;
                            count++;
                            if (count == 3) {
                              setState(() {
                                lastTime = DateTime.now();
                              });
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => ReplayPopUp(
                                      DragableShape.routname,
                                      firstTime,
                                      lastTime));
                            }
                            print(
                                "${itemList.indexOf(data)} ${_isDone} ${_elementState}");
                          });
                        },
                        builder: (BuildContext context, List incoming,
                            List rejected) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: newsize,
                              width: newsize,
                              child: _isDone[itemList
                                      .indexOf(itemList[_isDisplayed[lo]])]
                                  ? itemList[_isDisplayed[lo]].fill
                                  : itemList[_isDisplayed[lo]].stroke,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  0, screen.height * 0.05, 0, screen.height * 0.05),
              decoration: BoxDecoration(color: Colors.blueGrey),
              width: screen.width,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _ter.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Draggable<itemdata>(
                      data: itemList[_isDisplayed[_ter[index]]],
                      onDragStarted: () {},
                      childWhenDragging: Container(
                        height: newsize,
                        width: newsize,
                      ),
                      feedback: Container(
                        height: newsize,
                        width: newsize,
                        child: itemList[_isDisplayed[_ter[index]]].fill,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: newsize,
                              width: newsize,
                              child: _elementState[itemList.indexOf(
                                itemList[_isDisplayed[_ter[index]]],
                              )]
                                  ? Container()
                                  : itemList[_isDisplayed[_ter[index]]].fill)),
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
