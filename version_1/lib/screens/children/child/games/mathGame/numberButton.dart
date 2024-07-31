import 'package:flutter/material.dart';

class numberButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;

  numberButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var buttonColor = Color.fromARGB(255, 71, 10, 100);

    var whiteTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: screen.width * 0.07,
      color: Colors.white,
    );
    if (child == 'C') {
      buttonColor = Theme.of(context).primaryColorLight;
    } else if (child == 'DEL') {
      buttonColor = Theme.of(context).primaryColorLight;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              child,
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
