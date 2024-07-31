import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/childHome.dart';
import 'package:version_1/screens/children/child/events/events.dart';
import '../../../../main.dart';
import '../../../../model/eventTypesDet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../providers/auth.dart';

class addEventDetails extends StatefulWidget {
  static const routname = 'addEventDetails';

  const addEventDetails({super.key});

  @override
  State<addEventDetails> createState() => _addEventDetailsState();
}

class _addEventDetailsState extends State<addEventDetails> {
  final _types = types;
  bool _isloading = false;
  TextEditingController noteController = TextEditingController();
  final FocusNode note = FocusNode();
  @override
  void initState() {
    super.initState();
    note.addListener(() {
      setState(() {});
    });
    noteController.addListener(() {
      setState(() {});
    });
  }

  TimeOfDay _time = TimeOfDay.now();
  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(context,
        showTitleActions: true, onChanged: (date) {
      print('change $date in time zone ' + date.toString());
    }, onConfirm: (date) {
      setState(() {
        selectedDateTime = date;
      });
    }, currentTime: selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          backgroundColor: Theme.of(context).primaryColorLight,
          centerTitle: true,
          title: Text(
            "حدث جديد",
            style: TextStyle(
                fontSize: screen.width * 0.06,
                color: Theme.of(context).primaryColorDark),
          )),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Container(
              height: screen.height,
              width: screen.width,
              child: Center(
                child: ListView(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: screen.height * 0.01),
                      padding: EdgeInsets.symmetric(
                        horizontal: screen.width * 0.05,
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: screen.width,
                      child: Row(
                        children: [
                          Text(
                            "الحدث :",
                            style: TextStyle(
                                fontSize: screen.width * 0.06,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: EdgeInsets.all(screen.width * 0.05),
                            width: screen.width * 0.2,
                            height: screen.width * 0.2,
                            child: SvgPicture.asset(
                              _types[args['type']]!.image.toString(),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: screen.height * 0.77,
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.width * 0.05,
                          vertical: screen.height * 0.03),
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "الملاحظات :",
                                    style: TextStyle(
                                        fontSize: screen.width * 0.06,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: screen.width * 0.8,
                                  margin: EdgeInsets.symmetric(
                                      vertical: screen.height * 0.02),
                                  child: TextFormField(
                                    controller: noteController,
                                    focusNode: note,
                                    style: TextStyle(
                                        fontSize: screen.width * 0.05,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    maxLines: 4,
                                    keyboardType: TextInputType.multiline,
                                    textAlign: TextAlign.start,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      counterStyle:
                                          TextStyle(color: Colors.grey),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: note.hasFocus ? 25 : 20,
                                          fontWeight: note.hasFocus
                                              ? FontWeight.bold
                                              : FontWeight.w500),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "الساعة :",
                                    style: TextStyle(
                                        fontSize: screen.width * 0.06,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: screen.height * 0.02),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              style: BorderStyle.solid,
                                              width: 1)),
                                      fixedSize: MaterialStateProperty.all(Size(
                                          screen.width * 0.8,
                                          screen.height * 0.06)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                    ),
                                    child: Text(
                                      "${_time.hour}:${_time.minute}",
                                      style: TextStyle(
                                        fontSize: screen.width * 0.06,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        showPicker(
                                          value: _time,
                                          onChange: (TimeOfDay time) {
                                            setState(
                                              () {
                                                _time = time;
                                              },
                                            );
                                          },
                                          is24HrFormat: true,
                                          cancelText: "العودة",
                                          okText: "حفظ",
                                          hourLabel: "الساعة",
                                          minuteLabel: "الدقيقة",
                                          accentColor: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "التاريخ :",
                                    style: TextStyle(
                                        fontSize: screen.width * 0.06,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: screen.height * 0.02),
                                  height: screen.height * 0.06,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              style: BorderStyle.solid,
                                              width: 1)),
                                      fixedSize: MaterialStateProperty.all(Size(
                                          screen.width * 0.8,
                                          screen.height * 0.06)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                    ),
                                    child: Text(
                                      "${selectedDateTime.toLocal()}"
                                          .split(' ')[0],
                                      style: TextStyle(
                                        fontSize: screen.width * 0.045,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    onPressed: () => _selectDate(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: _isloading
                                ? CircularProgressIndicator()
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: screen.height * 0.03),
                                    width: screen.width * 0.9,
                                    child: TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isloading = true;
                                        });
                                        String d =
                                            "${selectedDateTime.toLocal()}"
                                                .split(' ')[0];
                                        final response = await http.post(
                                          Uri.parse(
                                              "http://${url}/events/${Provider.of<auth>(context, listen: false).childid}"),
                                          headers: {
                                            'Authorization':
                                                'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                          },
                                          body: json.encode(
                                            {
                                              'type': args['type'],
                                              'details': noteController.text,
                                              'day':
                                                  "${d} ${_time.hour}:${_time.minute}"
                                            },
                                          ),
                                        );

                                        var l = json.decode(response.body);
                                        setState(() {
                                          _isloading = false;
                                        });
                                        if (l["message"])
                                          Navigator
                                              .restorablePushNamedAndRemoveUntil(
                                                  context,
                                                  events.routname,
                                                  ModalRoute.withName(
                                                      childHome.routname));
                                      },
                                      child: Text(
                                        "إضافة",
                                        style: TextStyle(
                                            fontSize: 23, color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              Size(screen.width * 0.8,
                                                  screen.height * 0.055)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
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
            ),
          ),
        ),
      ),
    );
  }
}
