import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class childHomeCard extends StatelessWidget {
  final tap;
  final image;
  final name;
  const childHomeCard(this.name, this.image, this.tap);
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
          onTap: tap,
          child: Container(
            width: screen.width * 0.75,
            height: screen.width * 0.3,
            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.08),
            decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(255, 124, 124, 124),
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 2,
                  offset: Offset(3, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(200),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 231, 231, 231),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: screen.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset(image.toString(),
                        fit: BoxFit.fitWidth)),
                const Expanded(
                  child: SizedBox(),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: screen.width * 0.065,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ) /*InkWell(
        onTap: tap,
        child: Container(
          height: screen.width * 0.15,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 192, 192, 192),
                ]),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 124, 124, 124),
                blurRadius: 5,
                blurStyle: BlurStyle.normal,
                spreadRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screen.width * 0.12,
                height: screen.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(image),
              ),
              SizedBox(
                width: screen.width * 0.04,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: screen.width * 0.06, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),*/
        );
  }
}
