import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:version_1/model/http_exp.dart';
import 'package:version_1/providers/auth.dart';
import 'package:version_1/screens/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Color ligthpurple = Color.fromRGBO(200, 162, 200, 1);

class Login extends StatefulWidget {
  static const routename = 'Login';
  final void Function()? fun;
  Login(this.fun);

  @override
  State<Login> createState() => _LoginState(fun);
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formkey = GlobalKey();
  var _isLoading = false;

  @override
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusEmail.addListener(() {
      setState(() {});
    });
    focusPassword.addListener(() {
      setState(() {});
    });

    EmailController.addListener(() {
      setState(() {});
    });
    PasswordController.addListener(() {
      setState(() {});
    });
  }

  passwordvalid(val) {
    if (val!.isEmpty || val.length < 8) {
      return "كلمة المرور خاطئة";
    }
    return;
  }

  emailvalid(val) {
    if (val!.isEmpty || !val.contains('@')) {
      return "البريد اللإلكتروني خاطئ";
    }
    return;
  }

  bool _visible_password = false;
  final void Function()? fun2;
  _LoginState(this.fun2);
  Map<String, String> _data = {'email': '', 'password': ''};
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

  Future<void> _facebook(screen, surl, data) async {
    var message;
    setState(
      () {
        _isLoading = true;
      },
    );
    if (mounted) {
      message = await Provider.of<auth>(context, listen: false)
          .authenticate(data, surl)
          .then((value) {
        if (value != "true") {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
            _showErrorDialog(value.toString(), screen);
          }
        }
      });
    }
  }

  Future<void> _submit(screen, surl) async {
    if (!_formkey.currentState!.validate()) {
      return;
    } else {
      _data['email'] = EmailController.text;
      _data['password'] = PasswordController.text;
      print(_data);
      FocusScope.of(context).unfocus();
      _formkey.currentState!.save();
      var message;
      setState(
        () {
          _isLoading = true;
        },
      );
      if (mounted) {
        message = await Provider.of<auth>(context, listen: false)
            .authenticate(_data, surl)
            .then((value) {
          if (value != "true") {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
              _showErrorDialog(value.toString(), screen);
            }
          }
        });
      }

      ;
    }
  }

  Map _userobj = {};
  bool _isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    Color darkpurple = Theme.of(context).primaryColorLight;
    final screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height * 0.73,
      width: screen.width * 0.9,
      child: Center(
        child: Form(
          key: _formkey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: [
                Container(
                  width: screen.width * 0.3,
                  padding: EdgeInsets.fromLTRB(
                      screen.width * 0.03, 0, screen.width * 0.5, 0),
                  child: Image.asset(
                    "Kidzy.png",
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screen.height * 0.02,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: screen.width * 0.05),
                      controller: EmailController,
                      focusNode: focusEmail,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: darkpurple,
                        ),
                        hintText: "البريد الإلكتروني",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15.0),
                        labelText: "البريد الإلكتروني",
                        labelStyle: TextStyle(
                            color: darkpurple,
                            fontSize: focusEmail.hasFocus ? 30 : 20,
                            fontWeight: focusEmail.hasFocus
                                ? FontWeight.bold
                                : FontWeight.w500),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ligthpurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkpurple),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => emailvalid(val),
                    ),
                    SizedBox(
                      height: screen.height * 0.02,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: screen.width * 0.05),
                      controller: PasswordController,
                      obscureText: !_visible_password,
                      focusNode: focusPassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: darkpurple,
                        ),
                        hintText: "********",
                        hintStyle: TextStyle(color: ligthpurple),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15.0),
                        labelText: "كلمة المرور",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visible_password
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: darkpurple,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _visible_password = !_visible_password;
                              },
                            );
                          },
                        ),
                        labelStyle: TextStyle(
                            color: darkpurple,
                            fontSize: focusPassword.hasFocus ? 30 : 20,
                            fontWeight: focusPassword.hasFocus
                                ? FontWeight.bold
                                : FontWeight.w500),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ligthpurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkpurple),
                        ),
                      ),
                      validator: (val) => passwordvalid(val),
                    ),
                    SizedBox(
                      height: screen.height * 0.04,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      TextButton(
                        onPressed: () => _submit(screen, 'user/login'),
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(screen.width * 0.8, screen.height * 0.05)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(darkpurple)),
                      ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: screen.height * 0.02),
                      width: screen.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Divider(
                            color: Color.fromARGB(255, 79, 79, 79),
                            height: 5,
                          )),
                          SizedBox(
                            width: screen.width * 0.02,
                          ),
                          Text(
                            "أو",
                            style: TextStyle(
                              color: Color.fromARGB(255, 79, 79, 79),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: screen.width * 0.02,
                          ),
                          Expanded(
                            child: Divider(
                              color: Color.fromARGB(255, 79, 79, 79),
                              height: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screen.width * 0.02,
                    ),
                    Container(
                      width: screen.width * 0.8,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              FacebookAuth.instance.login(
                                permissions: ["public_profile", "email"],
                              ).then(
                                (value) {
                                  FacebookAuth.instance.getUserData().then(
                                    (data) async {
                                      print(data);
                                      _facebook(screen, 'facebook/login', {
                                        'email': data['email'],
                                        'firstname': data['username']
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              "تسجيل الدخول عبر فيسبوك",
                              style: TextStyle(fontSize: 20, color: darkpurple),
                            ),
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  color: darkpurple,
                                  width: screen.width * 0.005,
                                  style: BorderStyle.solid)),
                              fixedSize: MaterialStateProperty.all(Size(
                                  screen.width * 0.8, screen.height * 0.05)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "ليس لديك حساب؟",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 79, 79, 79)),
                              ),
                              TextButton(
                                onPressed: fun2,
                                child: Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                    color: darkpurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
