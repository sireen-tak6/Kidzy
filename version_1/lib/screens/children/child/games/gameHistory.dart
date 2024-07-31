import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/model/historycard.dart';

import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';

class gameHistory extends StatefulWidget {
  static const routname = 'gamesHistory';

  const gameHistory({super.key});

  @override
  State<gameHistory> createState() => _gameHistoryState();
}

class _gameHistoryState extends State<gameHistory> {
  var _isloading = false;
  List<DataRow> list = [];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var l = args['gameName'] == "لعبة الأشكال"
        ? 0
        : args['gameName'] == "لعبة الحسابات"
            ? 1
            : 2;
    var to = f(Provider.of<auth>(context, listen: false).token,
        "result/${l}/${Provider.of<auth>(context, listen: false).childid}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: Text(
          "النتائج السابقة",
          style: TextStyle(
              fontSize: screen.width * 0.06,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var _games;
          if (snapshot.data == null)
            _isloading = true;
          else {
            var _gamesAll = snapshot.data;
            _games = _gamesAll == null ? {} : _gamesAll["result"];
            print(_games);
            _games.forEach((e) {
              return list.add(DataRow(cells: [
                DataCell(
                  Center(
                    child: Text(
                      args['gameName'].toString(),
                      style: TextStyle(
                        fontSize: screen.width * 0.035,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      e["date"],
                      style: TextStyle(
                        fontSize: screen.width * 0.035,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      e["begin_time"],
                      style: TextStyle(
                        fontSize: screen.width * 0.035,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Text(
                      e["duration"] == null ? "" : e["duration"],
                      style: TextStyle(
                        fontSize: screen.width * 0.035,
                      ),
                    ),
                  ),
                ),
                DataCell(e["success"] == true
                    ? Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Center(
                        child: Text(
                          "X",
                          style: TextStyle(
                            fontSize: screen.width * 0.05,
                            color: Colors.red,
                          ),
                        ),
                      ))
              ]));
            });
            _isloading = false;
          }
          return _isloading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: screen.height,
                  width: screen.width,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*  Container(
                margin: EdgeInsets.symmetric(
                    vertical: screen.width * 0.07,
                    horizontal: screen.width * 0.04),
                child: Text(
                  "${args['gameName']} :",
                  style: TextStyle(
                      fontSize: screen.width * 0.06,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),*/
                        Container(
                          width: double.infinity,
                          child: DataTable(
                              columnSpacing: screen.width * 0.03,
                              border: TableBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  top: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  bottom: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  left: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  right: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight)),
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) {
                                  return Theme.of(context).primaryColorLight;
                                },
                              ),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    " اللعبة",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screen.width * 0.04,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    " اليوم",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screen.width * 0.04,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                    label: Text(
                                  "بداية اللعبة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screen.width * 0.04,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "مدة اللعب",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screen.width * 0.04,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  "النجاح",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screen.width * 0.04,
                                  ),
                                ))
                              ],
                              rows: list),
                        )
                      ],
                    ),
                  ),
                );
        },
        future: to.fe(),
      ),
      /*  ),
          ),
        )*/
    );
  }
}
