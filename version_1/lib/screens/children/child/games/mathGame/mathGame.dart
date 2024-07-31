import 'dart:math';

import 'package:flutter/material.dart';
import 'package:version_1/screens/children/child/games/popUp.dart';

import 'numberButton.dart';
import 'resaultDialog.dart';

class MathGame extends StatefulWidget {
  static const routname = 'MathGame';

  @override
  State<MathGame> createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  late var firstTime;
  late var lastTime;
  // number pad list
  List<String> numberPad = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    'C',
    '0',
    'DEL',
  ];

  // number A, number B
  late int numberA;
  late int numberB;
  @override
  void initState() {
    firstTime = DateTime.now();
    numberA = Random().nextInt(10);
    numberB = Random().nextInt(10);
    super.initState();
  }

  // user answer
  String userAnswer = '';

  // user tapped a button
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        // calculate if user is correct or incorrect
        checkResult();
      } else if (button == 'C') {
        // clear the input
        userAnswer = '';
      } else if (button == 'DEL') {
        // delete the last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        // maximum of 3 numbers can be inputted
        userAnswer += button;
      }
    });
  }

  // check if user is correct or not
  void checkResult() {
      setState(() {
        lastTime = DateTime.now();
      });
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          barrierColor: Color.fromARGB(102, 0, 0, 0),
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              ReplayPopUp(MathGame.routname, firstTime, lastTime));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return resaultDialog(MathGame.routname, firstTime, lastTime);
          });
    }
  }

  // create random numbers
  var randomNumber = Random();

  // GO TO NEXT QUESTION
  void goToNextQuestion() {
    // dismiss alert dialog
    Navigator.of(context).pop();

    // reset values
    setState(() {
      userAnswer = '';
    });

    // create a new question
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  // GO BACK TO QUESTION
  void goBackToQuestion() {
    // dismiss alert dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    var whiteTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: screen.width * 0.1,
      color: Color.fromARGB(255, 0, 0, 0),
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "لعبة الحسابات",
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
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // question
                            Text(
                              numberA.toString() +
                                  ' + ' +
                                  numberB.toString() +
                                  ' = ',
                              style: whiteTextStyle,
                            ),

                            // answer box
                            Container(
                              height: screen.height * 0.07,
                              width: screen.width * 0.2,
                              decoration: BoxDecoration(
                                color: Theme.of(context).hintColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  userAnswer,
                                  style: whiteTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).hintColor.withOpacity(0.5),
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.width * 0.05,
                          vertical: screen.height * 0.02),
                      child: Column(children: [
                        // number pad
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: GridView.builder(
                                itemCount: numberPad.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: screen.height * 0.08,
                                ),
                                itemBuilder: (context, index) {
                                  return numberButton(
                                    child: numberPad[index],
                                    onTap: () => buttonTapped(numberPad[index]),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextButton(
                            onPressed: checkResult,
                            child: Text(
                              "النتيجة",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white),
                            ),
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    Size(screen.width, screen.height * 0.055)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColorLight)),
                          ),
                        ),
                      ]),
                    ),
                  ), // question
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
