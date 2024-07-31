import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/repoController.dart';
import '../../providers/auth.dart';
import '../Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class profileScreen extends StatefulWidget {
  static const routname = 'profileScreen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  GlobalKey<FormState> FormKey = GlobalKey();
  valid(val) {
    if (val.isEmpty) {
      return 'هذا الحقل إلزامي';
    }
    return;
  }

  void _showErrorDialog(String errormes, screen) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            'حدث خطأ!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Text(
            errormes,
            style: TextStyle(
              fontSize: screen.width * 0.05,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              child: Text(
                'حسناً',
                style: TextStyle(
                  fontSize: screen.width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> create_dialog(
      BuildContext cont, screen, opid, title, first, last) {
    TextEditingController oldController = TextEditingController();
    TextEditingController newController = TextEditingController();
    TextEditingController newLastController = TextEditingController();
    TextEditingController newFirstController = TextEditingController();
    newFirstController.text = first.toString();
    newLastController.text = last.toString();
    var _nameData = {'firstname': '', 'lastname': ''};
    var _PasswordData = {'old_password': '', 'new_password': ''};

    bool _visibleOldPassword = false;
    bool _visibleNewPassword = false;
    return showDialog(
        context: cont,
        builder: (cont) {
          bool _isLoading2 = false;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Container(
                    width: screen.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${title} :",
                            style: TextStyle(
                                color: Theme.of(cont).primaryColorLight,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Theme.of(context).primaryColorLight,
                              size: screen.width * 0.07,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]),
                  ),
                  content: _isLoading2
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Form(
                          key: FormKey,
                          child: opid == 1
                              ? Container(
                                  height: screen.height * 0.23,
                                  width: screen.width * 0.99,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextFormField(
                                        controller: newFirstController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.person,
                                            size: screen.width * 0.05,
                                            color: Theme.of(cont)
                                                .primaryColorLight,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5.0),
                                          labelText: "الاسم الأول",
                                          labelStyle: TextStyle(
                                              color: Theme.of(cont)
                                                  .primaryColorLight,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Theme.of(cont).hintColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(cont)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                        validator: (value) => valid(value),
                                      ),
                                      SizedBox(
                                        height: screen.height * 0.02,
                                      ),
                                      TextFormField(
                                        style: TextStyle(fontSize: 15),
                                        controller: newLastController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.person_outline,
                                            size: screen.width * 0.05,
                                            color: Theme.of(cont)
                                                .primaryColorLight,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5.0),
                                          labelText: "اسم العائلة",
                                          labelStyle: TextStyle(
                                              color: Theme.of(cont)
                                                  .primaryColorLight,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    Theme.of(cont).hintColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(cont)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                        validator: (value) => valid(value),
                                      ),
                                    ],
                                  ))
                              : Container(
                                  height: screen.height * 0.23,
                                  width: screen.width * 0.99,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextFormField(
                                          controller: oldController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.lock_reset,
                                              size: screen.width * 0.05,
                                              color: Theme.of(cont)
                                                  .primaryColorLight,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5.0),
                                            labelText: "كلمة المرور القديمة",
                                            labelStyle: TextStyle(
                                                color: Theme.of(cont)
                                                    .primaryColorLight,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Theme.of(cont).hintColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(cont)
                                                      .primaryColorLight),
                                            ),
                                          ),
                                          validator: (value) => valid(value),
                                        ),
                                        SizedBox(
                                          height: screen.height * 0.02,
                                        ),
                                        TextFormField(
                                          obscureText: false,
                                          controller: newController,
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.lock,
                                              size: screen.width * 0.05,
                                              color: Theme.of(cont)
                                                  .primaryColorLight,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15.0),
                                            labelText: "كلمة المرور الجديدة",
                                            labelStyle: TextStyle(
                                                color: Theme.of(cont)
                                                    .primaryColorLight,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Theme.of(cont).hintColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(cont)
                                                      .primaryColorLight),
                                            ),
                                          ),
                                          validator: (value) => valid(value),
                                        ),
                                      ])),
                        ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        var l;
                        if (!FormKey.currentState!.validate()) {
                          return;
                        } else {
                          setState(() {
                            _isLoading2 = true;
                          });
                          if (opid == 1) {
                            setState(() {
                              _nameData['firstname'] = newFirstController.text;
                              _nameData['lastname'] = newLastController.text;
                              print(_nameData);
                            });
                            final response = await http.post(
                                Uri.parse("http://${url}/configuration"),
                                headers: {
                                  'Authorization':
                                      'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                },
                                body: json.encode(_nameData));

                            l = json.decode(response.body);
                          } else {
                            setState(() {
                              _PasswordData['old_password'] =
                                  oldController.text;
                              _PasswordData['new_password'] =
                                  newController.text;
                              print(_PasswordData);
                            });
                            final response = await http.post(
                                Uri.parse("http://${url}/user/resetpassword"),
                                headers: {
                                  'Authorization':
                                      'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                },
                                body: json.encode(_PasswordData));

                            l = json.decode(response.body);
                          }
                          setState(() {
                            _isLoading2 = false;
                          });
                          if (l["message"]) {
                            if (opid == 1) {
                              Provider.of<auth>(context, listen: false)
                                  .changeName(_nameData['firstname'],
                                      _nameData['lastname']);
                            }
                            Navigator.of(cont).pop();
                          } else {
                            _showErrorDialog(
                                "حدث خطأ ما يرجى المحاولة مجدداً", screen);
                            Navigator.of(cont).pop();
                          }
                        }
                      },
                      child: Text(
                        "حفظ التغييرات",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(screen.width * 0.3, screen.height * 0.03)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(cont).primaryColorLight)),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget info(screen, title, info, edit, cont, opid, first, last) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screen.width * 0.05),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    info,
                    style: TextStyle(
                        color: Color.fromARGB(255, 116, 116, 116),
                        fontWeight: FontWeight.bold,
                        fontSize: screen.width * 0.035),
                  ),
                ],
              ),
            ],
          ),
          if (edit)
            IconButton(
                onPressed: () =>
                    create_dialog(cont, screen, opid, title, first, last),
                icon: Icon(Icons.edit)),
        ],
      ),
    );
  }

  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var to =
        f(Provider.of<auth>(context, listen: false).token, "configuration");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "حسابي",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      endDrawer: DrawerPage(),
      body: FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var _mother;
          if (snapshot.data == null)
            _isloading = true;
          else {
            var _motherAll = snapshot.data;
            _mother = _motherAll == null ? {} : _motherAll["mother"];
            print(_mother);
            _isloading = false;
          }
          return _isloading || _mother == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Column(
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
                                  height: screen.width * 0.2,
                                  width: screen.width * 0.2,
                                  child: Image.asset(
                                    "userIcon.png",
                                  ),
                                ),
                                Text(
                                  "${_mother['firstname'].toString()} ${_mother['lastname']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screen.width * 0.05),
                                ),
                                Text(
                                  _mother['email'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screen.width * 0.05),
                                ),
                              ],
                            ),
                          ),
                          height: screen.height * 0.3,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 62, 62, 62),
                                blurRadius: 8,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(98, 55, 117, 1),
                                Color.fromARGB(255, 61, 27, 75),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screen.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.all(screen.width * 0.05),
                          width: screen.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              info(
                                  screen,
                                  "الاسم",
                                  "${_mother['firstname']} ${_mother['lastname']}",
                                  true,
                                  context,
                                  1,
                                  _mother['firstname'],
                                  _mother['lastname']),
                              divider(),
                              info(
                                  screen,
                                  "البريد الإكتروني",
                                  "${_mother['email']} ",
                                  false,
                                  context,
                                  2,
                                  _mother['firstname'],
                                  _mother['lastname']),
                              divider(),
                              info(
                                  screen,
                                  "كلمة المرور",
                                  "********",
                                  true,
                                  context,
                                  3,
                                  _mother['firstname'],
                                  _mother['lastname']),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
        future: to.fe(),
      ),
    );
  }

  Divider divider() {
    return Divider(
      color: Color.fromARGB(255, 227, 227, 227),
      endIndent: 10,
      indent: 10,
      thickness: 1,
      height: 30,
    );
  }
}
