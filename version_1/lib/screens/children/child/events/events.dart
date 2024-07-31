import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:version_1/model/event.dart';
import 'package:version_1/model/eventLast.dart';
import 'package:version_1/model/eventTypesDet.dart';
import 'package:version_1/screens/children/child/events/addEvent.dart';

import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';
import '../childDrawer.dart';
import 'event.dart';

class events extends StatelessWidget {
  static const routname = 'events';

  final typesImage = types;
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var to = f(Provider.of<auth>(context, listen: false).token,
        "events/${Provider.of<auth>(context).childid}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "الأحداث",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      endDrawer: childDrawerPage(),
      body: FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var _events;
          var LastTime;
          if (snapshot.data == null)
            _isloading = true;
          else {
            var _eventsAll = snapshot.data;
            _events = _eventsAll == null ? [] : _eventsAll["date"];
            LastTime = _eventsAll == null ? [] : _eventsAll["latest_events"];
            print(LastTime);
            print(_events);

            _isloading = false;
          }
          return _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: screen.width * 0.25,
                          width: screen.width,
                          child: ListView.builder(
                            itemCount: LastTime.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  eventTime(
                                      LastTime[index]['date'],
                                      screen,
                                      typesImage[LastTime[index]['type']]!
                                          .image),
                                  eventSpaceBar(screen)
                                ],
                              );
                            },
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Container(
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: Container(
                            child: _events[0]['date'] != null
                                ? ListView.builder(
                                    itemCount: _events.length,
                                    itemBuilder: (context, index) {
                                      print(_events[index]);
                                      // return Text("${_events[index]}");
                                      return dateEvent(_events[index], screen);
                                    })
                                : Text(""),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(addEvent.routname),
                            child: Text(
                              "إضافة حدث",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(
                                    screen.width * 0.9, screen.height * 0.06)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColorLight)),
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

  dateEvent(map, screen) {
    return Column(
      children: [
        Divider(
          color: Color.fromARGB(255, 228, 228, 228),
          height: screen.height * 0.01,
          thickness: 1,
        ),
        Text(
          map['date'].toString(),
          style: TextStyle(
              fontSize: screen.width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
        Divider(
          indent: screen.width * 0.2,
          endIndent: screen.width * 0.2,
          height: screen.height * 0.01,
          color: Color.fromARGB(255, 228, 228, 228),
          thickness: 1,
        ),
        if (map["events"] != null)
          Container(
            child: Column(
              children: [
                for (int i = 0; i < map['events'].length; i++)
                  event(map['events'][i])
              ],
            ),
          ),
        Divider(
          color: Color.fromARGB(255, 228, 228, 228),
          height: screen.height * 0.01,
          thickness: 1,
        ),
      ],
    );
  }

  eventSpaceBar(screen) {
    return SizedBox(width: screen.width * 0.02);
  }

  eventTime(img, h, color) {
    return Container(
      width: h.width * 0.21,
      height: h.width * 0.18,
      child: Center(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: SvgPicture.asset(
                    color.toString(),
                  ),
                  height: h.width * 0.16,
                  width: h.width * 0.16,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: h.width * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 231, 230, 230),
                  ),
                  child: Center(
                    child: Text(img.toString(),
                        style: TextStyle(fontSize: h.width * 0.03)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
