import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/doctors/add_review_button.dart';
import 'package:version_1/screens/doctors/doctor_info_card.dart';
import 'package:version_1/screens/doctors/doctor_name.dart';
import 'package:version_1/screens/doctors/review_card.dart';

import '../../model/repoController.dart';
import '../../providers/auth.dart';

class doctor_info extends StatefulWidget {
  static const routname = 'doctor_info';

  const doctor_info({super.key});

  @override
  State<doctor_info> createState() => _doctor_infoState();
}

class _doctor_infoState extends State<doctor_info> {
  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final screen = MediaQuery.of(context).size;

    var to = f(Provider.of<auth>(context, listen: false).token,
        "doctor/${int.parse(args['id'].toString())}");
    String name = args["name"].toString();
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
            backgroundColor: Theme.of(context).primaryColorLight,
            centerTitle: true,
            title: Text(
              name,
              style: TextStyle(
                  fontSize: screen.width * 0.06,
                  color: Theme.of(context).primaryColorDark),
            )),
        body: FutureBuilder<dynamic>(
          builder: (context, snapshot) {
            var _doctorsAll;
            var _doc_infos;
            var _reviews;
            if (snapshot.data == null)
              _isloading = true;
            else {
              _doctorsAll = snapshot.data;
              _doc_infos = _doctorsAll == null ? {} : _doctorsAll["doc info"];
              _reviews = _doctorsAll == null ? {} : _doctorsAll["reviews"];
              print(_doc_infos);
              print(_reviews);

              _isloading = false;
            }

            if (_isloading)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(screen.width * 0.02),
                    child: Column(
                      children: [
                        doctor_name(args['image'], _doc_infos['firstname'],
                            _doc_infos['lastname'], args['rate']),
                        space(screen),
                        doctor_info_card(
                            _doc_infos['Address'],
                            _doc_infos['profession'],
                            _doc_infos['contact'],
                            _doc_infos['opentime'],
                            _doc_infos['closed_time']),
                        space(screen),
                        review_card(_reviews),
                        space(screen),
                        review_button(
                            _doc_infos['id'],
                            "${_doc_infos['firstname']} ${_doc_infos['lastname']}",
                            args['image'],
                            args['rate'])
                      ],
                    ),
                  ),
                ),
              );
          },
          future: to.fe(),
        ));
  }
}

Column space(screen) {
  return Column(children: [
    SizedBox(
      height: screen.height * 0.01,
    ),
    Divider(
      color: Color.fromARGB(255, 207, 207, 207),
      endIndent: 20,
      indent: 20,
      thickness: 1,
    ),
    SizedBox(
      height: screen.height * 0.01,
    ),
  ]);
}
