import 'package:flutter/material.dart';
import 'package:version_1/screens/auth/Login.dart';
import 'package:version_1/screens/auth/SignUp.dart';
import 'package:version_1/screens/auth/authBackground.dart';

class authScreenAnimated extends StatefulWidget {
  static const routname = 'authScreenAnimated';
  const authScreenAnimated({super.key});

  @override
  State<authScreenAnimated> createState() => _authScreenAnimatedState();
}

authMode authmode = authMode.Login;
Map<String, String> _authMap = {
  'FirstName': '',
  'LastName': '',
  'Email': '',
  'Password': '',
};

enum authMode { Login, SignUp }

class _authScreenAnimatedState extends State<authScreenAnimated> {
  @override
  Widget build(BuildContext context) {
    void swithAuthMode() {
      if (authmode == authMode.SignUp) {
        setState(() {
          authmode = authMode.Login;
        });
      } else {
        setState(() {
          authmode = authMode.SignUp;
        });
      }
    }

    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            authBackground(screen),
            Center(
              child: AnimatedCrossFade(
                  firstChild: Login(swithAuthMode),
                  secondChild: SignUp(swithAuthMode),
                  crossFadeState: authmode == authMode.Login
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 700)),
            ),
          ],
        ),
      ),
    );
  }
}
