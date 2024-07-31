import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version_1/screens/articles/article_content.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../providers/auth.dart';

class articleCard extends StatefulWidget {
  final int _id;
  final String _title;
  final String _website;
  String? _age;
  final String _date;
  int _isfav;
  bool mom;
  articleCard(this._title, _age, this._date, this._website, this._id,
      this._isfav, this.mom) {
    _age == null ? this._age = null : this._age = _age.toString();
  }

  @override
  State<articleCard> createState() => _articleCardState();
}

class _articleCardState extends State<articleCard> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    print(widget._age);
    final screen = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, article_content.routname,
            arguments: {'id': widget._id, 'mom': widget.mom});
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    top: screen.width * 0.04,
                    bottom: screen.width * 0.04,
                    left: screen.width * 0.04,
                    right: screen.width * 0.028),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screen.width * 0.15,
                            height: screen.width * 0.15,
                            child: Center(
                                child: Text(
                              widget._age != null ? "${widget._age} شهر" : "",
                              style: TextStyle(
                                  fontSize: screen.width * 0.05,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorLight),
                            )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ]),
                    SizedBox(
                      width: screen.width * 0.05,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget._title}",
                            softWrap: false,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: screen.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: screen.width * 0.01,
                          ),
                          Text(
                            "الناشر : ${widget._website}",
                            softWrap: false,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: screen.width * 0.035,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 20, 20, 20)),
                          ),
                          SizedBox(
                            height: screen.width * 0.02,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Row(children: [
                                  Text(
                                    'تاريخ النشر : ${widget._date}',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: screen.width * 0.03),
                                  ),
                                ]),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isloading = true;
                                    });
                                    final response = await http.post(
                                        Uri.parse(widget.mom
                                            ? "http://${url}/favorite/artical"
                                            : "http://${url}/fav_baby_artical/${Provider.of<auth>(context, listen: false).childid}"),
                                        headers: {
                                          'Authorization':
                                              'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                        },
                                        body: json.encode(
                                            {'artical_id': widget._id}));

                                    var l = json.decode(response.body);
                                    setState(() {
                                      _isloading = false;
                                    });
                                    setState(() {
                                      if (widget._isfav == 1) {
                                        widget._isfav = 0;
                                      } else {
                                        widget._isfav = 1;
                                      }
                                    });
                                  },
                                  icon: _isloading
                                      ? CircularProgressIndicator()
                                      : widget._isfav == 1
                                          ? Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            )
                                          : Icon(Icons.favorite_border_outlined,
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 3,
              color: Color.fromARGB(255, 226, 226, 226),
            ),
          ],
        ),
      ),
    );
  }
}
