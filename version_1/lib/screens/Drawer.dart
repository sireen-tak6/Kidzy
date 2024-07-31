import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/auth/authScreenAnimated.dart';
import 'package:version_1/screens/auth/logout.dart';
import 'package:version_1/screens/navbar.dart';
import 'package:version_1/screens/profile/profileScreen.dart';

import '../providers/auth.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _name = Provider.of<auth>(
      context,
    ).name;
    var _email = Provider.of<auth>(context).email;

    final screen = MediaQuery.of(context).size;

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
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        height: screen.width * 0.11,
                        width: screen.width * 0.11,
                        child: Image.asset(
                          "userIcon.png",
                        ),
                      ),
                      Text(
                        _name.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width * 0.045),
                      ),
                      Text(
                        _email.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width * 0.045),
                      ),
                    ]),
              ),
              height: screen.height * 0.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromRGBO(98, 55, 117, 1),
                    Color.fromARGB(255, 61, 27, 75)
                  ])),
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
                        context, navBar.routname),
                  ),
                  Divider(
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
                      " حسابي ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, profileScreen.routname),
                  ),
                  Divider(
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
                      " تسجيل الخروج ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onTap: () async {
                      String message =
                          await Provider.of<auth>(context, listen: false)
                              .logout();
                      if (message == "true") {
                        Navigator.of(context)
                            .pushReplacementNamed(authScreenAnimated.routname);
                      }
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
