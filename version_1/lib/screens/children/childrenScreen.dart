// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/addChildSex.dart';
import 'package:version_1/screens/children/oneChild.dart';
import '../../model/repoController.dart';
import '../../providers/auth.dart';
import 'childCard.dart';

// ignore: camel_case_types
class childrenScreen extends StatefulWidget {
  const childrenScreen({super.key});

  @override
  State<childrenScreen> createState() => _childrenScreenState();
}

// ignore: camel_case_types
class _childrenScreenState extends State<childrenScreen> {
  var colorlist = [
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 251, 241, 255),
            Color.fromARGB(255, 234, 192, 231)
          ])
    },
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(253, 252, 214, 1),
            Color.fromARGB(255, 255, 254, 245),
          ]),
    },
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 245, 246, 255),
            Color.fromARGB(255, 178, 186, 240),
          ]),
    },
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 241, 255, 252),
            Color.fromARGB(255, 200, 239, 240),
          ]),
    },
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 229, 255, 227),
            Color.fromARGB(255, 168, 218, 165),
          ]),
    },
    {
      'boolean': 0,
      'gr': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 255, 249, 236),
            Color.fromARGB(255, 254, 215, 174),
          ])
    }
  ];
  LinearGradient col() {
    // ignore: prefer_typing_uninitialized_variables
    var colo;
    int f = 1;
    int ind;
    while (f == 1) {
      ind = Random().nextInt(colorlist.length);

      colo = colorlist[ind]['gr'];
      f = int.parse(colorlist[ind]['boolean'].toString());
      if (f == 0) {
        print('$ind $f ${colorlist[ind]['boolean']}');

        colorlist[ind]['boolean'] = 1;
        print('$ind $f ${colorlist[ind]['boolean']}');
      }
    }
    return colo;
  }

  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var to = f(Provider.of<auth>(context, listen: false).token, "child");
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          _isloading = true;
        } else {
          _isloading = false;
        }
        var _childrenAll = snapshot.data;
        var _children = _childrenAll == null ? {} : _childrenAll["childs"];
        print(_children);
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const addChildSex())),
              backgroundColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(children: [
                Scaffold(
                  body: Container(
                    width: screen.width,
                    height: screen.height,
                    child: Image.asset(
                      "b1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (_isloading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: _children.length != 0
                        ? _children.length > 1
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 30),
                                itemBuilder: (context, index) => childCard(
                                    _children[index]["id"],
                                    _children[index]["name"],
                                    _children[index]["gender"],
                                    col()),
                                itemCount: _children.length,
                              )
                            : oneChild(
                                _children[0]["id"],
                                _children[0]["name"],
                                _children[0]["gender"],
                              )
                        : Container(
                            width: screen.width,
                            child: Text(
                              "لا يوجد بيانات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screen.width * 0.075,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                          ),
                  ),
              ]),
            ));
      },
      future: to.fe(),
    );
  }
}
