import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/auth/authScreenAnimated.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';
import '../../providers/auth.dart';

Color ligthpurple = const Color.fromRGBO(200, 162, 200, 1);

class SignUp extends StatefulWidget {
  static const routename = 'Signup';
  final void Function()? fun;

  const SignUp(this.fun);

  @override
  State<SignUp> createState() => _SignUpState(fun);
}

class _SignUpState extends State<SignUp> {
  bool _visible_password = false;
  final void Function()? fun2;
  _SignUpState(this.fun2);
  GlobalKey<FormState> _formkey = GlobalKey();
  var _isLoading = false;
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
              color: const Color.fromARGB(255, 0, 0, 0),
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

  void _showcheckDialog(screen) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Text(
            "يرجى التحقق من البريد الإلكتروني ثم تسجيل الدخول",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: screen.width * 0.05,
                color: Colors.black),
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
              onPressed: () => Navigator.pushReplacementNamed(
                  context, authScreenAnimated.routname),
            ),
          ],
        ),
      ),
    );
  }

  final FocusNode focusFirstName = FocusNode();
  final FocusNode focusLastName = FocusNode();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final TextEditingController FirstNameController = TextEditingController();
  final TextEditingController LastNameController = TextEditingController();
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
    focusFirstName.addListener(() {
      setState(() {});
    });
    focusLastName.addListener(() {
      setState(() {});
    });
    FirstNameController.addListener(() {
      setState(() {});
    });

    LastNameController.addListener(() {
      setState(() {});
    });
    EmailController.addListener(() {
      setState(() {});
    });
    PasswordController.addListener(() {
      setState(() {});
    });
  }

  emailvalid(val) {
    if (val!.isEmpty || !val.contains('@')) {
      return "البريد الإلكتروني خاطئ";
    }
    return;
  }

  firstnamevalid(val) {
    if (val!.isEmpty) {
      return "هذا الحقل إلزامي";
    }
    return;
  }

  lastnamevalid(val) {
    if (val!.isEmpty) {
      return "هذا الحقل إلزامي";
    }
    return;
  }

  passwordvalid(val) {
    if (val!.isEmpty || val.length < 8) {
      return "يجب أن تحتوي كلمة المرور على أكثر من 8 أحرف";
    }
    return;
  }

  Map<String, String> _data = {
    "firstname": "",
    "lastname": "",
    "email": "",
    "password": "",
  };

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

  Future<void> _submit(screen) async {
    if (!_formkey.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formkey.currentState!.save();
      _data['email'] = EmailController.text.toString();
      _data['password'] = PasswordController.text.toString();
      _data['firstname'] = FirstNameController.text.toString();
      _data['lastname'] = LastNameController.text.toString();
      print(_data);
      setState(
        () {
          _isLoading = true;
        },
      );

      final response = await http.post(Uri.parse("http://${url}/user/signup"),
          body: json.encode(_data));

      var l = json.decode(response.body);
      /*try {
        await Provider.of<auth>(context, listen: false)
            .signUp(_data['Email']!, _data['Password']!, _data['FullName']!);
      } on HttpExc catch (error) {
        var errorMes = 'Authentication failed';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMes = 'email exists';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMes = 'invalid email';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMes = 'weak password';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMes = 'email not found';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMes = 'invalid password';
        }

        _showErrorDialog(errorMes);
      } catch (error) {
        const errorMes = "couldn't authenticate you . please try again later.";
        _showErrorDialog(errorMes);
      }*/
      setState(() {
        _isLoading = false;
      });
      if (l["message"] == true) {
        _showcheckDialog(screen);
      } else {
        _showErrorDialog(l["message"], screen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    Color darkpurple = Theme.of(context).primaryColorLight;
    return Container(
      height: screen.height * 0.88,
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
                      height: screen.height * 0.01,
                    ),
                    TextFormField(
                      controller: FirstNameController,
                      focusNode: focusFirstName,
                      style: TextStyle(fontSize: screen.width * 0.05),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: darkpurple,
                        ),
                        hintText: "الاسم الأول",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15.0),
                        labelText: "الاسم الأول",
                        labelStyle: TextStyle(
                            color: darkpurple,
                            fontSize: focusFirstName.hasFocus ? 30 : 20,
                            fontWeight: focusFirstName.hasFocus
                                ? FontWeight.bold
                                : FontWeight.w500),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ligthpurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkpurple),
                        ),
                      ),
                      validator: (val) => firstnamevalid(val),
                    ),
                    SizedBox(
                      height: screen.height * 0.005,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: screen.width * 0.05),
                      controller: LastNameController,
                      focusNode: focusLastName,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                          color: darkpurple,
                        ),
                        hintText: "اسم العائلة",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15.0),
                        labelText: "اسم العائلة",
                        labelStyle: TextStyle(
                            color: darkpurple,
                            fontSize: focusLastName.hasFocus ? 30 : 20,
                            fontWeight: focusLastName.hasFocus
                                ? FontWeight.bold
                                : FontWeight.w500),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ligthpurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkpurple),
                        ),
                      ),
                      validator: (val) => lastnamevalid(val),
                    ),
                    SizedBox(
                      height: screen.height * 0.005,
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
                      height: screen.height * 0.005,
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 15.0),
                        labelText: "كلمة المرور",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _visible_password
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: darkpurple,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _visible_password = !_visible_password;
                            });
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
                      const CircularProgressIndicator()
                    else
                      TextButton(
                        onPressed: () async {
                          _submit(screen);
                        },
                        child: const Text(
                          "إنشاء حساب",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(screen.width * 0.8, screen.height * 0.05)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(darkpurple)),
                      ),
                    SizedBox(
                      height: screen.height * 0.02,
                    ),
                    Container(
                      width: screen.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              child: Divider(
                            color: Color.fromARGB(255, 79, 79, 79),
                            height: 3,
                          )),
                          SizedBox(
                            width: screen.width * 0.02,
                          ),
                          const Text(
                            "أو",
                            style: TextStyle(
                              color: Color.fromARGB(255, 79, 79, 79),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: screen.width * 0.02,
                          ),
                          const Expanded(
                              child: Divider(
                            color: Color.fromARGB(255, 79, 79, 79),
                            height: 3,
                          )),
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
                              "إنشاء حساب عن طريق فيسبوك",
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
                              )),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "هل لديك حساب؟",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 79, 79, 79)),
                              ),
                              TextButton(
                                onPressed: fun2,
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(color: darkpurple),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
  inputstyle(FocusNode focusnode, String labeltext, TextInputType textinputtype,
      Function valid, Function save) {
    TextFormField(
      focusNode: focusnode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 15.0),
        labelText: labeltext,
        labelStyle:
            TextStyle(color: focusnode.hasFocus ? darkpurple : ligthpurple),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ligthpurple),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkpurple),
        ),
      ),
      keyboardType: textinputtype,
      validator: (val) => valid(val),
      onSaved: (val) => save(val),
    );
  }*/
}
