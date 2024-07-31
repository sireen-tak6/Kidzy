import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:version_1/model/eventTypesDet.dart';
import 'package:version_1/screens/children/child/events/eventDetails.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../../providers/auth.dart';

class event extends StatefulWidget {
  final eventmap;
  event(
    this.eventmap,
  );

  @override
  State<event> createState() => _eventState();
}

class _eventState extends State<event> {
  final images = types;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        eventDetails.routname,
        arguments: {"id": widget.eventmap["id"]},
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screen.width * 0.13,
              height: screen.width * 0.13,
              child: SvgPicture.asset(images[widget.eventmap['type']]!.image),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                widget.eventmap['details'].toString(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: screen.width * 0.04, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: screen.width * 0.1,
              child: Text(
                widget.eventmap['day'].toString().substring(0, 5),
                style: TextStyle(
                    fontSize: screen.width * 0.04,
                    color: Color.fromARGB(255, 122, 122, 122),
                    fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () =>
                  create_dialog(context, screen, widget.eventmap["id"]),
              child: Container(
                width: screen.width * 0.1,
                child: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).primaryColorLight,
                  size: screen.width * 0.06,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> create_dialog(BuildContext cont, screen, id) {
    bool _isloading2 = false;
    return showDialog(
        context: cont,
        builder: (cont) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: _isloading2
                  ? Text("")
                  : Container(
                      width: screen.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "هل تريد حذف الحدث؟",
                              style: TextStyle(
                                  color: Theme.of(cont).primaryColorLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(cont),
                              child: Text(
                                "X",
                                style: TextStyle(
                                    fontSize: screen.height * 0.025,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ]),
                    ),
              actions: _isloading2
                  ? []
                  : [
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            _isloading2 = true;
                          });
                          var response = await http.delete(
                            Uri.parse("http://${url}/event/${id}"),
                            headers: {
                              'Authorization':
                                  'Bearer ${Provider.of<auth>(cont, listen: false).token}'
                            },
                          );
                          var l = json.decode(response.body);
                          if (l["message"]) {
                            Navigator.pop(cont);
                          }
                        },
                        child: Text(
                          "حذف",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screen.width * 0.04,
                            color: Theme.of(cont).primaryColorLight,
                          ),
                        ),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                              color: Theme.of(cont).primaryColorLight,
                              width: screen.width * 0.005,
                              style: BorderStyle.solid)),
                          fixedSize: MaterialStateProperty.all(
                              Size(screen.width * 0.3, screen.height * 0.03)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                        ),
                      )
                    ],
            ),
          );
        });
  }
}
