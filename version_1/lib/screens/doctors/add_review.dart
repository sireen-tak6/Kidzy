import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';

class add_review extends StatefulWidget {
  final id;
  final name;
  int getId() {
    return id;
  }

  Map<String, Object> rating_info = {
    'content': '',
    'rating': 0,
  };
  add_review(this.id, this.name);

  @override
  State<add_review> createState() => _add_reviewState();
}

class _add_reviewState extends State<add_review> {
  String _counterText = "";
  GlobalKey<FormState> _FormKey = GlobalKey();

  TextEditingController opinionController = TextEditingController();
  final FocusNode opinion = FocusNode();
  @override
  void initState() {
    super.initState();
    opinion.addListener(() {
      setState(() {});
    });
    opinionController.addListener(() {
      setState(() {});
    });
  }

  var _isLoading = false;
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
    final screen = MediaQuery.of(context).size;
    Future<void> _add() async {
      if (!_FormKey.currentState!.validate()) {
        return;
      } else {
        widget.rating_info['content'] = opinionController.text;

        setState(
          () {
            _isLoading = true;
          },
        );

        final response = await http.post(
            Uri.parse("http://${url}/doctor/${widget.id}"),
            headers: {
              'Authorization':
                  'Bearer ${Provider.of<auth>(context, listen: false).token}'
            },
            body: json.encode(widget.rating_info));

        var l = json.decode(response.body);
        setState(() {
          _isLoading = false;
        });

        print(widget.rating_info);
        if (l["message"]) {
          Navigator.pop(context);
        } else {
          _showErrorDialog("حدث خطأ ما", screen);
        }
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: screen.width * 1,
        maxHeight: screen.height * 0.7,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _FormKey,
            child: ListView(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -15,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          width: 60,
                          height: screen.height * 0.005,
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screen.width * 0.1,
                          horizontal: screen.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screen.width * 0.05),
                            child: Text(
                              "اكتب رأيك عن الدكتور/ة ${widget.name}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: screen.width * 0.06,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: screen.height * 0.02,
                          ),
                          TextFormField(
                            controller: opinionController,
                            focusNode: opinion,
                            style: TextStyle(
                                fontSize: screen.width * 0.05,
                                color: Theme.of(context).primaryColorLight),
                            maxLength: 120,
                            minLines: 4,
                            maxLines: 6,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) => setState(() {
                              _counterText = (120 - value.length).toString();
                            }),
                            textAlign: TextAlign.start,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              hintText: "اكتب ما تفكر به...",
                              alignLabelWithHint: true,
                              label: Text("رأيك"),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              counterStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: opinion.hasFocus ? 25 : 20,
                                  fontWeight: opinion.hasFocus
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight),
                              ),
                            ),
                            validator: (value) => opinionValid(value),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 207, 207, 207),
                            endIndent: 5,
                            indent: 5,
                            thickness: 1,
                            height: screen.height * 0.05,
                          ),
                          Text(
                            "ما هو تقييمك؟",
                            style: TextStyle(
                                fontSize: screen.width * 0.06,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorLight),
                          ),
                          SizedBox(
                            height: screen.height * 0.02,
                          ),
                          RatingBar.builder(
                            glow: false,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            allowHalfRating: true,
                            unratedColor: Colors.grey[600],
                            minRating: 0,
                            initialRating: widget.rating_info['rating'] == null
                                ? 0
                                : double.parse(
                                    widget.rating_info['rating']!.toString()),
                            itemSize: screen.width * 0.1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal: screen.width * 0.03),
                            onRatingUpdate: (double value) {
                              setState(() {
                                widget.rating_info['rating'] = value.toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: screen.height * 0.05,
                          ),
                          TextButton(
                            onPressed: () {
                              _add();
                              setState(() {});
                            },
                            child: Text(
                              "إضافة التقييم",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(
                                    screen.width * 0.8, screen.height * 0.05)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColorLight)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  opinionValid(val) {
    if (val!.isEmpty) {
      return 'هذا الحقل إلزامي ..';
    }
    return;
  }
}
