import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/repoController.dart';
import '../../providers/auth.dart';
import 'doctor_card.dart';

class doctorsScreen extends StatefulWidget {
  const doctorsScreen({super.key});

  @override
  State<doctorsScreen> createState() => _doctorsScreenState();
}

class _doctorsScreenState extends State<doctorsScreen> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var to = f(Provider.of<auth>(context, listen: false).token, "doctors");
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.data == null)
          _isloading = true;
        else
          _isloading = false;
        var _doctorsAll = snapshot.data;
        var _doctors = _doctorsAll == null ? {} : _doctorsAll["Doctors"];
        print(_doctors);
        return Stack(children: [
          Scaffold(
            body: Container(
              width: screen.width,
              height: screen.height,
              child: Image.asset(
                "b1.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isloading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            _doctors.length != 0
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          doctorCard(
                            _doctors[index]["Name"],
                            _doctors[index]["address"],
                            _doctors[index]["Profession"],
                            _doctors[index]["gender"],
                            _doctors[index]["rate"].toDouble(),
                            _doctors[index]["id"],
                          ),
                        ],
                      );
                    },
                    itemCount: _doctors.length,
                  )
                : Container(
                    width: screen.width,
                    child: Text(
                      "لا يوجد بيانات",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screen.width * 0.075,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  )
        ]);
      },
      future: to.fe(),
    );
  }
}
