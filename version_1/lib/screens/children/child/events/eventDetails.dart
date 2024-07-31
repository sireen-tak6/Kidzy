import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/childHome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:version_1/screens/children/child/events/events.dart';

import '../../../../main.dart';
import '../../../../model/eventTypesDet.dart';
import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';

class eventDetails extends StatefulWidget {
  static const routname = 'eventDetails';

  eventDetails({super.key});

  @override
  State<eventDetails> createState() => _eventDetailsState();
}

class _eventDetailsState extends State<eventDetails> {
  TextEditingController detailsController = TextEditingController();
  var _isChanged = false;
  final FocusNode details = FocusNode();
  final images = types;

  @override
  void initState() {
    super.initState();
    details.addListener(() {
      setState(() {});
    });
    detailsController.addListener(() {
      setState(() {});
    });
  }

  Map<String, String> _data = {'Details': ""};
  var _isloading = false;
  var _isloading2 = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    var to = f(Provider.of<auth>(context, listen: false).token,
        "event/${arguments["id"]}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Image.asset(
          "Kidzy2.png",
          width: screen.width * 0.2,
        ),
      ),
      body: FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var args;
          if (snapshot.data == null)
            _isloading = true;
          else {
            var _eventsAll = snapshot.data;
            args = _eventsAll == null ? {} : _eventsAll["event"];
            _isloading = false;
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  Scaffold(
                    body: Container(
                      height: screen.height,
                      width: screen.width,
                      child: Image.asset(
                        "b1.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  _isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: screen.width,
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: screen.height * 0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: screen.width * 0.3,
                                              width: screen.width * 0.3,
                                              child: SvgPicture.asset(
                                                images[args['type']]!.image,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screen.width * 0.08,
                                            ),
                                            SizedBox(
                                              height: screen.width * 0.45,
                                              width: 3,
                                              child: Container(
                                                  color: Theme.of(context)
                                                      .highlightColor),
                                            ),
                                            SizedBox(
                                              width: screen.width * 0.08,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  args['day'].toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          screen.width * 0.06,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  args['time']
                                                      .toString()
                                                      .substring(0, 5),
                                                  style: TextStyle(
                                                      fontSize:
                                                          screen.width * 0.05,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 36, 36, 36)),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: screen.height * 0.1,
                                    ),
                                    Container(
                                      height: screen.height * 0.3,
                                      width: screen.width * 0.85,
                                      child: TextFormField(
                                        focusNode: details,
                                        initialValue:
                                            args['details'].toString(),
                                        style: TextStyle(
                                          fontSize: screen.width * 0.05,
                                        ),
                                        maxLines: 6,
                                        keyboardType: TextInputType.multiline,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          counterStyle:
                                              TextStyle(color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color:
                                                    Theme.of(context).hintColor,
                                                width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          if (value != args['details']) {
                                            setState(() {
                                              _isChanged = true;
                                              _data['Details'] = value;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screen.height * 0.09),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: screen.height * 0.03),
                                  child: _isloading2
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : TextButton(
                                          onPressed: _isChanged
                                              ? () async {
                                                  setState(() {
                                                    _isloading2 = true;
                                                  });
                                                  print({
                                                    "event_id": arguments["id"],
                                                    "type": args["type"],
                                                    "day":
                                                        "${args["day"]} ${args["time"]}",
                                                    "details": _data['Details']
                                                        .toString()
                                                  });

                                                  final response =
                                                      await http.post(
                                                    Uri.parse(
                                                        "http://${url}/event/${arguments['id']}"),
                                                    headers: {
                                                      'Authorization':
                                                          'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                                    },
                                                    body: json.encode(
                                                      {
                                                        'event_id':
                                                            arguments["id"],
                                                        'type': args['type'],
                                                        'day':
                                                            "${args['day']} ${args['time']}",
                                                        'details':
                                                            _data['Details']
                                                                .toString()
                                                      },
                                                    ),
                                                  );
                                                  var l = json
                                                      .decode(response.body);
                                                  if (l["message"] == true) {
                                                    Navigator
                                                        .restorablePushNamedAndRemoveUntil(
                                                      context,
                                                      events.routname,
                                                      ModalRoute.withName(
                                                          childHome.routname),
                                                    );
                                                  }
                                                }
                                              : () {},
                                          child: Text(
                                            "حفظ التغييرات",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: _isChanged
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColorDark),
                                          ),
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          screen.width * 0.9,
                                                          screen.height *
                                                              0.05)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      !_isChanged
                                                          ? Colors.grey
                                                          : Theme.of(context)
                                                              .primaryColorLight)),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        future: to.fe(),
      ),
    );
  }
}
