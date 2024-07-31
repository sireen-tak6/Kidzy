import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:version_1/model/repoController.dart';

import '../../providers/auth.dart';

class article_content extends StatefulWidget {
  static const routname = 'article_content';

  @override
  State<article_content> createState() => _article_contentState();
}

class _article_contentState extends State<article_content> {
  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final screen = MediaQuery.of(context).size;
    var to = f(
        Provider.of<auth>(context, listen: false).token,
        args['mom'] == true
            ? "artical/${int.parse(args['id'].toString())}"
            : "baby_artical/${int.parse(args['id'].toString())}");
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        var _articles;
        if (snapshot.data == null) {
          _isloading = true;
        } else {
          _articles = snapshot.data;
          _isloading = false;
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
          body: Stack(children: [
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
            if (_isloading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _articles['title'].toString(),
                          style: TextStyle(
                              fontSize: screen.width * 0.075,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screen.height * 0.02,
                        ),
                        Text(
                          _articles['for_age'] != null
                              ? "العمر : ${_articles['for_age'].toString()} شهر"
                              : "العمر : ",
                          style: TextStyle(
                              fontSize: screen.width * 0.038,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 20, 20, 20)),
                        ),
                        SizedBox(
                          height: screen.height * 0.05,
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: ReadMoreText(
                              _articles['Content'].toString(),
                              style: TextStyle(
                                  fontSize: screen.width * 0.05,
                                  color: Colors.black),
                              trimLines: 3,
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: "رؤية المزيد",
                              trimExpandedText: ".",
                              lessStyle: TextStyle(
                                  fontSize: screen.width * 0.045,
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0)),
                              moreStyle: TextStyle(
                                  fontSize: screen.width * 0.045,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screen.height * 0.1,
                        ),
                        Text(
                          "الناشر : ${_articles['website'].toString()}",
                          style: TextStyle(
                              fontSize: screen.width * 0.035,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 20, 20, 20)),
                        ),
                        SizedBox(
                          height: screen.height * 0.01,
                        ),
                        Text(
                          "تاريخ النشر : ${_articles['publish_date'].toString()}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: screen.width * 0.03,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: screen.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
          ]),
        );
      },
      future: to.fe(),
    );
  }
}
