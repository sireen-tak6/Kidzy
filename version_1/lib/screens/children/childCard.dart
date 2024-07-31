import 'package:flutter/material.dart';
import 'package:version_1/screens/children/child/childHome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';

class childCard extends StatefulWidget {
  final _id;
  final _name;
  final _male;
  final col;
  var info;
  late String _image;
  childCard(
    this._id,
    this._name,
    this._male,
    this.col,
  ) {
    if (_male == 1) {
      _image = "boy.png";
    } else {
      _image = "girl.png";
    }
    info = {'name': _name, 'id': _id};
  }

  @override
  State<childCard> createState() => _childCardState();
}

class _childCardState extends State<childCard> {
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
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showcheckDialog(screen) {
      showDialog(
        context: context,
        builder: (ctx) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Container(
              width: screen.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "هل تريد حذف ${widget._name}؟",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screen.width * 0.05,
                          color: Colors.black),
                      textDirection: TextDirection.rtl,
                    ),
                    Align(
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Theme.of(context).primaryColorLight,
                          size: screen.width * 0.07,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ]),
            ),
            actions: [
              TextButton(
                child: Text(
                  'نعم',
                  style: TextStyle(
                    fontSize: screen.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () async {
                  final response = await http.delete(
                    Uri.parse("http://${url}/child/${widget._id}"),
                    headers: {
                      'Authorization':
                          'Bearer ${Provider.of<auth>(context, listen: false).token}'
                    },
                  );

                  var l = json.decode(response.body);
                  if (l['message']) {
                    setState(() {});
                    Navigator.pop(context);
                  } else {
                    _showErrorDialog("حدث خطأ ما يرجى المحاولة مجدداً", screen);
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    final screen = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          Provider.of<auth>(context, listen: false).childname = widget._name;
          Provider.of<auth>(context, listen: false).childid = widget._id;
          Provider.of<auth>(context, listen: false).childgender = widget._male;

          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              settings: const RouteSettings(name: childHome.routname),
              builder: (context) => new childHome()));
        },
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: screen.width * 0.32,
                height: screen.width * 0.32,
                decoration: BoxDecoration(
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
                  gradient: widget.col,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: screen.width * 0.13,
                        height: screen.width * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(widget._image)),
                    Text(
                      widget._name,
                      style: TextStyle(
                          fontSize: screen.width * 0.06,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screen.width * 0.32,
                height: screen.width * 0.08,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 124, 124, 124),
                      blurRadius: 5,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 1.5,
                      offset: Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(80, 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(185, 98, 55, 117))),
                    onPressed: () => _showcheckDialog(screen),
                    child: Text(
                      "حذف",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: screen.width * 0.035,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
