// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_brace_in_string_interps, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';
import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';
import '../childDrawer.dart';
import 'package:version_1/screens/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class childProfile extends StatefulWidget {
  static const routname = 'childProfile';

  const childProfile({super.key});

  @override
  State<childProfile> createState() => _childProfileState();
}

class _childProfileState extends State<childProfile> {
  GlobalKey<FormState> FormKey = GlobalKey();

  valid(val) {
    if (val.isEmpty) {
      return 'هذا الحقل إلزامي';
    }
    return;
  }

  List<Map<String, String>> normal = [
    {'type': '(طبيعي)', 'color': '0xFF4CAF50'},
    {
      'type': '(أعلى من الطبيعي)',
      'color': '0xFFB71C1C',
    },
    {
      'type': '(أقل من الطبيعي)',
      'color': '0xFF2196F3',
    }
  ];

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

  Future<dynamic> create_dialog(BuildContext cont, screen, opid, title, info) {
    TextEditingController newweightController = TextEditingController();
    TextEditingController newheightController = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    var _weightData = {'weight': ''};
    // ignore: no_leading_underscores_for_local_identifiers
    var _heightData = {'height': ''};
    opid == 1
        ? newheightController.text = info.toString()
        : newweightController.text = info.toString();
    return showDialog(
        context: cont,
        builder: (cont) {
          // ignore: no_leading_underscores_for_local_identifiers
          bool _isLoading2 = false;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                              color: Theme.of(cont).primaryColorLight,
                              size: screen.width * 0.07,
                            ),
                            onPressed: () {
                              Navigator.pop(cont);
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
                                  height: screen.height * 0.08,
                                  width: screen.width * 0.99,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextFormField(
                                        controller: newheightController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.height,
                                            size: screen.width * 0.05,
                                            color: Theme.of(cont)
                                                .primaryColorLight,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5.0),
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
                                        keyboardType: TextInputType.number,
                                        validator: (value) => valid(value),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: screen.height * 0.08,
                                  width: screen.width * 0.99,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextFormField(
                                        controller: newweightController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.monitor_weight_outlined,
                                            size: screen.width * 0.05,
                                            color: Theme.of(cont)
                                                .primaryColorLight,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5.0),
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
                                        keyboardType: TextInputType.number,
                                        validator: (value) => valid(value),
                                      ),
                                    ],
                                  ),
                                )),
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
                              _heightData['height'] = newheightController.text;
                              print(_heightData);
                            });
                            final response = await http.post(
                                Uri.parse(
                                    "http://${url}/babyheight/${Provider.of<auth>(cont, listen: false).childid}"),
                                headers: {
                                  'Authorization':
                                      'Bearer ${Provider.of<auth>(cont, listen: false).token}'
                                },
                                body: json.encode(_heightData));

                            l = json.decode(response.body);
                          } else {
                            setState(() {
                              _weightData['weight'] = newweightController.text;
                              print(_weightData);
                            });
                            final response = await http.post(
                                Uri.parse(
                                    "http://${url}/babyweight/${Provider.of<auth>(cont, listen: false).childid}"),
                                headers: {
                                  'Authorization':
                                      'Bearer ${Provider.of<auth>(cont, listen: false).token}'
                                },
                                body: json.encode(_weightData));

                            l = json.decode(response.body);
                          }
                          setState(() {
                            _isLoading2 = false;
                          });
                          if (l["message"]) {
                            Navigator.of(cont).pop();
                          } else {
                            _showErrorDialog(
                                "حدث خطأ ما يرجى المحاولة مجدداً", screen);
                            Navigator.of(cont).pop();
                          }
                        }
                      },
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
                      child: const Text(
                        "حفظ التغييرات",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Divider divider() {
    return const Divider(
      color: Color.fromARGB(255, 227, 227, 227),
      endIndent: 10,
      indent: 10,
      thickness: 1,
      height: 30,
    );
  }

  _info(title, info, edit, cont, opid, screen, status) {
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
                  fontSize: screen.width * 0.055,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 116, 116, 116),
                      fontWeight: FontWeight.w500,
                      fontSize: screen.width * 0.05,
                    ),
                  ),
                  if (status != -1)
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          normal[status]['type'].toString(),
                          style: TextStyle(
                            fontSize: screen.width * 0.045,
                            color: Color(
                              int.parse(normal[status]['color']!),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          if (edit)
            IconButton(
              onPressed: () => create_dialog(cont, screen, opid, title, info),
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
    );
  }

  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    var childid = Provider.of<auth>(context).childid;
    final screen = MediaQuery.of(context).size;
    var _name = Provider.of<auth>(context).name;
    var to = f(
        Provider.of<auth>(context, listen: false).token, "confbaby/${childid}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "حساب الطفل",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      endDrawer: childDrawerPage(),
      body: FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var _child;
          var _h;
          var _w;
          if (snapshot.data == null) {
            _isloading = true;
          } else {
            var _childAll = snapshot.data;
            _child = _childAll["baby"];
            _h = _childAll["height"] != null
                ? _childAll["height"]["message"] == "طبيعي"
                    ? 0
                    : _childAll["height"]["message"] == "اعلى من الطبيعي"
                        ? 1
                        : 2
                : -1;
            _w = _childAll["weight"] != null
                ? _childAll["weight"]["message"] == "طبيعي"
                    ? 0
                    : _childAll["weight"]["message"] == "اعلى من الطبيعي"
                        ? 1
                        : 2
                : -1;
            print(_child);
            _isloading = false;
          }
          return _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(98, 55, 117, 1),
                              Color.fromARGB(255, 61, 27, 75)
                            ],
                          ),
                        ),
                        height: screen.height * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, navBar.routname),
                              child: Container(
                                width: screen.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: screen.width * 0.08,
                                      width: screen.width * 0.08,
                                      child: Image.asset(
                                        "userIcon.png",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _name.toString(),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              height: screen.width * 0.16,
                              width: screen.width * 0.16,
                              child: Image.asset(
                                _child["gender"] == 1 ? "boy.png" : "girl.png",
                              ),
                            ),
                            Text(
                              _child["name"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screen.width * 0.075),
                            ),
                          ],
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
                            _info("الاسم", _child["name"].toString(), false,
                                context, 0, screen, -1),
                            divider(),
                            _info(
                                "الجنس",
                                _child["gender"] == 1 ? "ذكر" : "أنثى",
                                false,
                                context,
                                0,
                                screen,
                                -1),
                            divider(),
                            _info(
                                "تاريخ الميلاد",
                                _child["date_of_birth"].toString(),
                                false,
                                context,
                                0,
                                screen,
                                -1),
                            divider(),
                            _info('الطول', _child["height"].toString(), true,
                                context, 1, screen, _h),
                            divider(),
                            _info('الوزن', _child["weight"].toString(), true,
                                context, 2, screen, _w),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
        future: to.fe(),
      ),
    );
  }
}
