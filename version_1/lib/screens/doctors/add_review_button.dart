import 'package:flutter/material.dart';
import 'package:version_1/screens/doctors/add_review.dart';
import 'package:version_1/screens/doctors/doctor_info.dart';

class review_button extends StatefulWidget {
  final id;
  final name;
  final _rate;
  final _image;

  review_button(this.id, this.name, this._image, this._rate);

  @override
  State<review_button> createState() => _review_buttonState();
}

class _review_buttonState extends State<review_button> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                builder: (BuildContext ctx) {
                  return add_review(widget.id, widget.name);
                });
            print('o');
          },
          child: Text(
            "إضافة تقييم",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size(screen.width * 0.9, screen.height * 0.06)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColorLight)),
        ),
      ],
    );
  }
}
