import 'package:flutter/material.dart';
import 'package:version_1/screens/children/addChild.dart';

class addChildSex extends StatelessWidget {
  static const routname = 'addChildSex';

  const addChildSex({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Image.asset(
          "Kidzy2.png",
          width: screen.width * 0.2,
        ),
      ),
      body: Stack(children: [
        Scaffold(
          body: Container(
            height: screen.height,
            width: screen.width,
            child: Image.asset(
              "b1.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: screen.height * 0.05),
                width: screen.width,
                height: screen.height * 0.9,
                child: Column(
                  children: [
                    Text(
                      "جنس الطفل :",
                      style: TextStyle(
                          fontSize: screen.width * 0.085,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screen.height * 0.09),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, addChild.routname,
                                      arguments: {'male': true});
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: screen.width * 0.4,
                                          height: screen.width * 0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Image.asset("boy.png")),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, addChild.routname,
                                      arguments: {'male': false});
                                },
                                child: Container(
                                    width: screen.width * 0.4,
                                    height: screen.width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.asset("girl.png")),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
