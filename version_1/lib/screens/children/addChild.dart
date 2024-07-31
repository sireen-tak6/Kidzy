import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/childrenScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';
import '../../providers/auth.dart';
import '../Drawer.dart';
import '../navbar.dart';

class addChild extends StatefulWidget {
  static const routname = 'addChild';

  @override
  State<addChild> createState() => _addChildState();
}

class _addChildState extends State<addChild> {
  GlobalKey<FormState> _formkey = GlobalKey();
  late bool _male;
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
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  DateTime selectedDateTime = DateTime.now();
  bool pressed = false;
  final FocusNode focusname = FocusNode();
  final FocusNode focusheight = FocusNode();
  final FocusNode focusweight = FocusNode();
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

  valid(val) {
    if (val!.isEmpty) {
      return "هذا الحقل إلزامي";
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  @override
  void initState() {
    super.initState();
    focusname.addListener(() {
      setState(() {});
    });
    focusheight.addListener(() {
      setState(() {});
    });
    focusweight.addListener(() {
      setState(() {});
    });
    nameController.addListener(() {
      setState(() {});
    });
    heightController.addListener(() {
      setState(() {});
    });
    weightController.addListener(() {
      setState(() {});
    });
  }

  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    _male = args['male']!;

    var info = {
      'name': '',
      'date_of_birth': '',
      'height': 0,
      'weight': 0,
      'gender': _male,
    };

    Future<void> _add() async {
      if (!_formkey.currentState!.validate()) {
        return;
      } else {
        info['name'] = nameController.text;
        info['height'] = int.parse(heightController.text);
        info['weight'] = int.parse(weightController.text);
        info['gender'] = _male;
        info['date_of_birth'] =
            selectedDateTime.toLocal().toString().split(' ')[0];
        print(info);
        setState(
          () {
            _isLoading = true;
          },
        );

        final response = await http.post(Uri.parse("http://${url}/child"),
            headers: {
              'Authorization':
                  'Bearer ${Provider.of<auth>(context, listen: false).token}'
            },
            body: json.encode(info));

        var l = json.decode(response.body);
        setState(() {
          _isLoading = false;
        });
        if (l["message"]) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          _showErrorDialog("حدث خطأ ما", screen);
        }
      }
    }

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
      body: GestureDetector(
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
            Form(
              key: _formkey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  children: [
                    Container(
                      width: screen.width,
                      height: screen.height,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Text(
                                  "معلومات أخرى :",
                                  style: TextStyle(
                                      fontSize: screen.width * 0.085,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                ),
                                SizedBox(
                                  height: screen.height * 0.04,
                                ),
                                Container(
                                    width: screen.width * 0.35,
                                    height: screen.width * 0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.asset(_male == true
                                        ? "boy.png"
                                        : "girl.png")),
                                SizedBox(
                                  height: screen.height * 0.06,
                                ),
                                Container(
                                  height: screen.height * 0.06,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    cursorColor:
                                        Theme.of(context).primaryColorLight,
                                    cursorHeight: screen.height * 0.025,
                                    focusNode: focusname,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 25, horizontal: 15.0),
                                      labelText: "الاسم",
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: focusname.hasFocus
                                              ? screen.width * 0.04
                                              : screen.width * 0.035,
                                          fontWeight: focusname.hasFocus
                                              ? FontWeight.bold
                                              : FontWeight.w600),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                    ),
                                    validator: (val) => valid(val),
                                  ),
                                ),
                                SizedBox(
                                  height: screen.height * 0.05,
                                ),
                                Container(
                                  height: screen.height * 0.06,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: screen.height * 0.06,
                                        width: screen.width * 0.35,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          controller: heightController,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                          cursorColor: Theme.of(context)
                                              .primaryColorLight,
                                          cursorHeight: screen.height * 0.025,
                                          focusNode: focusheight,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.height,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                            labelText: "الطول (cm)",
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.start,
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: focusheight.hasFocus
                                                    ? screen.width * 0.04
                                                    : screen.width * 0.035,
                                                fontWeight: focusheight.hasFocus
                                                    ? FontWeight.bold
                                                    : FontWeight.w600),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                            ),
                                          ),
                                          validator: (val) => valid(val),
                                        ),
                                      ),
                                      Container(
                                        height: screen.height * 0.06,
                                        width: screen.width * 0.35,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          controller: weightController,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                          cursorColor: Theme.of(context)
                                              .primaryColorLight,
                                          cursorHeight: screen.height * 0.025,
                                          focusNode: focusweight,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.monitor_weight_outlined,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25,
                                                    horizontal: 15.0),
                                            labelText: "الوزن (kg)",
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: focusweight.hasFocus
                                                    ? screen.width * 0.04
                                                    : screen.width * 0.035,
                                                fontWeight: focusweight.hasFocus
                                                    ? FontWeight.bold
                                                    : FontWeight.w600),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                            ),
                                          ),
                                          validator: (val) => valid(val),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screen.height * 0.05,
                                ),
                                Container(
                                  height: screen.height * 0.06,
                                  child: TextButton.icon(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              style: BorderStyle.solid,
                                              width: 1)),
                                      fixedSize: MaterialStateProperty.all(Size(
                                          screen.width * 1,
                                          screen.height * 0.06)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                    ),
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                    label: Text(
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
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            Container(
                              width: screen.width * 0.8,
                              child: TextButton(
                                onPressed: _add,
                                child: Text(
                                  "إضافة",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(
                                        screen.width * 0.8,
                                        screen.height * 0.055)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColorLight)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
          )
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
          );
  }
}

class addChild extends StatefulWidget {
  static const routname = 'addChild';

  @override
  _addChildState createState() => _addChildState();
}

class _addChildState extends State<addChild> {
  DateTime selectedDateTime = DateTime.now();
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    pressed = true;

                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onChanged: (date) {
                      print('change $date in time zone ' + date.toString());
                    }, onConfirm: (date) {
                      selectedDateTime = date;
                    }, currentTime: selectedDateTime);
                  });
                },
                child: Text(
                  'Select Date Time',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            SizedBox(height: 50),
            pressed ? _displayDateTime(selectedDateTime) : SizedBox(),
          ],
        ),
      ),
    );
  }
}

Widget _displayDateTime(selectedDateTime) {
  return Center(
      child: Text(
    "Selected  $selectedDateTime",
    style: TextStyle(fontSize: 15),
  ));
}
*/