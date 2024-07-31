import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:version_1/screens/children/child/games/gamesHome.dart';
import 'package:version_1/screens/children/child/games/memoryGame/gameHome.dart';
import 'package:version_1/screens/children/child/games/memoryGame/test.dart';

import '../../../../main.dart';
import '../../../../providers/auth.dart';

const messages = ['رائع', 'أحسنت', 'ممتاز'];

class ReplayPopUp extends StatefulWidget {
  final game;
  final DateTime firstTime;
  final DateTime _lastTime;
  ReplayPopUp(this.game, this.firstTime, this._lastTime);

  @override
  State<ReplayPopUp> createState() => _ReplayPopUpState();
}

class _ReplayPopUpState extends State<ReplayPopUp> {
  var _isloading = true;
  late DateTime lastTime;
  sendData(_data) async {
    final response = await http.post(
        Uri.parse(
            "http://${url}/result/${_data["Game_number"]}/${_data["child_id"]}"),
        headers: {
          'Authorization':
              'Bearer ${Provider.of<auth>(context, listen: false).token}'
        },
        body: json.encode(_data));

    var l = json.decode(response.body);
    return l;
  }

  @override
  void initState() {
    lastTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final r = Random().nextInt(messages.length);
    var formattedDate = intl.DateFormat('yyyy-MM-dd').format(widget.firstTime);
    var formattedtime = intl.DateFormat('HH:mm:ss').format(widget.firstTime);

    var diff = lastTime.difference(widget.firstTime);
    var diffMi = diff.inMinutes > 9
        ? diff.inMinutes.toString()
        : diff.inMinutes.toString().padLeft(2, '0');
    var diffse = (diff.inSeconds - (diff.inMinutes * 60)) > 9
        ? (diff.inSeconds - (diff.inMinutes * 60)).toString()
        : (diff.inSeconds - (diff.inMinutes * 60)).toString().padLeft(2, '0');

    var _data = {
      "success": true,
      "Game_number": widget.game == "DragableShape"
          ? 0
          : widget.game == "MathGame"
              ? 1
              : 2,
      "Date": formattedDate.toString(),
      "begin_time": formattedtime.toString(),
      "duration": "${diffMi.toString()}:${diffse.toString()}",
      "child_id": int.parse(Provider.of<auth>(context).childid == null
          ? "-1"
          : Provider.of<auth>(context).childid.toString())
    };
    String message = messages[r];
    var whiteTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: screen.width * 0.06,
      color: Color.fromARGB(255, 0, 0, 0),
    );
    return FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          if (snapshot.data == null)
            _isloading = true;
          else {
            var _send = snapshot.data;
            var _sendmessage = _send == null ? {} : _send["message"];
            _isloading = false;
          }

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: _isloading
                ? Text("")
                : Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screen.width * 0.08,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
            content: _isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: screen.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "المدة : ${diffMi.toString()}:${diffse.toString()} ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width * 0.06,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '🥳',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60),
                        ),
                      ],
                    ),
                  ),
            actionsAlignment: MainAxisAlignment.center,
            actions: _isloading
                ? []
                : [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.restorablePushNamedAndRemoveUntil(
                              context,
                              widget.game,
                              ModalRoute.withName(gamesHome.routname));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('اللعب مجدداً'),
                        ),
                      ),
                    ),
                  ],
          );
        },
        future: sendData(_data));
  }
}
