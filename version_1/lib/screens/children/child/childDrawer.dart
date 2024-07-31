import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/childHome.dart';
import 'package:version_1/screens/children/child/childProfile/childProfile.dart';
import 'package:version_1/screens/navbar.dart';
import 'package:version_1/screens/profile/profileScreen.dart';

import '../../../providers/auth.dart';

class childDrawerPage extends StatelessWidget {
  const childDrawerPage();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var _mothername = Provider.of<auth>(context).name;
    var _id = Provider.of<auth>(context).childid;
    var _name = Provider.of<auth>(context).childname;
    var _gender = Provider.of<auth>(context).childgender;
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromRGBO(98, 55, 117, 1),
                    Color.fromARGB(255, 61, 27, 75)
                  ])),
              height: screen.height * 0.25,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, navBar.routname),
                    child: Container(
                      width: screen.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            height: screen.width * 0.08,
                            width: screen.width * 0.08,
                            child: Image.asset(
                              "userIcon.png",
                            ),
                          ),
                          Text(
                            _mothername.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screen.width * 0.04),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              height: screen.width * 0.14,
                              width: screen.width * 0.14,
                              child: _gender == 1
                                  ? Image.asset(
                                      "boy.png",
                                    )
                                  : Image.asset(
                                      "girl.png",
                                    ),
                            ),
                            Text(
                              _name.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screen.width * 0.065),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: screen.height,
              child: Column(
                children: [
                  SizedBox(
                    height: screen.height * 0.05,
                  ),
                  ListTile(
                    focusColor: Theme.of(context).primaryColorDark,
                    selectedColor: Theme.of(context).primaryColorDark,
                    selectedTileColor: Theme.of(context).primaryColorDark,
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      " الصفحة الرئيسية",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, childHome.routname),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 207, 207, 207),
                    endIndent: 5,
                    indent: 15,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.manage_accounts,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      " حساب الطفل",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, childProfile.routname),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 207, 207, 207),
                    endIndent: 5,
                    indent: 15,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      " العودة إلى صفحة الأم",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onTap: () {
                      Provider.of<auth>(context, listen: false).childgender =
                          null;
                      Provider.of<auth>(context, listen: false).childid = null;
                      Provider.of<auth>(context, listen: false).childname =
                          null;

                      Navigator.pushReplacementNamed(context, navBar.routname);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
