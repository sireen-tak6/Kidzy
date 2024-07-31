import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/article.dart';
import '../../../../model/articles.dart';
import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';
import '../../../articles/article_card.dart';

class childArticlesFav extends StatefulWidget {
  const childArticlesFav({super.key});

  @override
  State<childArticlesFav> createState() => _childArticlesFavState();
}

class _childArticlesFavState extends State<childArticlesFav> {
  // List<article> _articles = articles;
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    print("llllll");
    var to = f(Provider.of<auth>(context, listen: false).token,
        "fav_baby_artical/${Provider.of<auth>(context).childid}");
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        var _articlesAll;
        var _articles;
        if (snapshot.data == null) {
          _isloading = true;
        } else {
          _articlesAll = snapshot.data;
          print(_articlesAll);
          _articles = _articlesAll["articals"];
          _isloading = false;
        }
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
            _articles?.length != 0
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      return articleCard(
                          _articles[index]['title'],
                          _articles[index]['for_age'],
                          _articles[index]['publish_date'],
                          _articles[index]['website'],
                          _articles[index]['id'],
                          1,
                          false);
                    },
                    itemCount: _articles?.length,
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
