import 'package:flutter/material.dart';

class doctor_info_card extends StatelessWidget {
  final _address;
  final _profession;
  final _contact;
  final _open;
  final _close;

  const doctor_info_card(
      this._address, this._profession, this._contact, this._open, this._close);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.02),
      child: Column(children: [
        Row(
          children: [
            Text(
              "العنوان:",
              style: labelStyle(screen, context),
            ),
            Text(
              " ${_address.toString()}",
              style: textStyle(screen, context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "الاختصاص :",
              style: labelStyle(screen, context),
            ),
            Text(
              " ${_profession.toString()} ",
              style: textStyle(screen, context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "الهاتف :",
              style: labelStyle(screen, context),
            ),
            Text(
              " ${_contact.toString()} ",
              style: textStyle(screen, context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "يفتح :",
              style: labelStyle(screen, context),
            ),
            Text(
              " ${_open.toString()} ",
              style: textStyle(screen, context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "يغلق :",
              style: labelStyle(screen, context),
            ),
            Text(
              " ${_close.toString()} ",
              style: textStyle(screen, context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ]),
    );
  }
}

TextStyle labelStyle(screen, ctx) {
  return TextStyle(
      fontSize: screen.width * 0.05,
      fontWeight: FontWeight.w600,
      color: Theme.of(ctx).primaryColorLight);
}

TextStyle textStyle(screen, ctx) {
  return TextStyle(
      fontSize: screen.width * 0.05,
      fontWeight: FontWeight.w500,
      color: Colors.black54);
}
