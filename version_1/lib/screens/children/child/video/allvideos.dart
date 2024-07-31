import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version_1/screens/children/child/video/pl.dart';
import '../../../../main.dart';
import '../../../../model/repoController.dart';
import '../../../../providers/auth.dart';
import 'package:http/http.dart' as http;

class allVideos extends StatefulWidget {
  const allVideos({super.key});

  @override
  State<allVideos> createState() => _allVideosState();
}

class _allVideosState extends State<allVideos> {
  bool _playArea = false;
  int id = -1;
  var _isloading = false;
  var _isloading2 = false;
  int _id = -1;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    var to = f(Provider.of<auth>(context, listen: false).token, "videos");
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
      FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          var _videosAll;
          var _videos;
          if (snapshot.data == null) {
            _isloading = true;
          } else {
            _videosAll = snapshot.data;
            print(_videosAll);
            _videos = _videosAll["videos"];
            _isloading = false;
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).hintColor,
                  ],
                  begin: FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              ),
              child: Column(
                children: [
                  if (_playArea == true)
                    Container(
                      width: screen.width,
                      height: screen.height * 0.25,
                      child: videoHome(_videos[id]['video_link']),
                    ),
                  Expanded(
                    child: _isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                if (_playArea)
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      _videos[id]['title'].toString(),
                                      style: TextStyle(
                                          fontSize: screen.width * 0.06,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                Expanded(
                                  child: _videos.length != 0
                                      ? ListView.builder(
                                          itemBuilder: (ctx, index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              id = index;
                                                              if (_playArea ==
                                                                  false) {
                                                                _playArea =
                                                                    true;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            color: Colors.white,
                                                            width: screen.width,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .all(screen
                                                                          .width *
                                                                      0.04),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width: screen.width *
                                                                            0.16,
                                                                        height: screen.width *
                                                                            0.16,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                        ),
                                                                        child: Image.asset(
                                                                            "assets/pics/${_videos[index]['image']}"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: screen
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _videos[index]
                                                                          [
                                                                          'title'],
                                                                      style: TextStyle(
                                                                          fontSize: screen.width *
                                                                              0.055,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                  _isloading2 &&
                                                                          _id ==
                                                                              index
                                                                      ? Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        )
                                                                      : IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            setState(() {
                                                                              _id = index;
                                                                              _isloading2 = true;
                                                                            });
                                                                            final response = await http.post(Uri.parse("http://${url}/favorite/video"),
                                                                                headers: {
                                                                                  'Authorization': 'Bearer ${Provider.of<auth>(context, listen: false).token}'
                                                                                },
                                                                                body: json.encode({
                                                                                  'video_id': _videos[index]['id']
                                                                                }));

                                                                            var l =
                                                                                json.decode(response.body);
                                                                            setState(() {
                                                                              _isloading2 = false;
                                                                            });
                                                                            if (l['message']) {
                                                                              setState(() {
                                                                                _videos[index]['favorite'] == 1 ? _videos[index]['favorite'] = 0 : _videos[index]['favorite'] = 1;
                                                                              });
                                                                            }
                                                                          },
                                                                          icon: _videos[index]['favorite'] == 1
                                                                              ? Icon(
                                                                                  Icons.favorite,
                                                                                  color: Theme.of(context).primaryColorLight,
                                                                                )
                                                                              : Icon(Icons.favorite_border_outlined, color: Theme.of(context).primaryColorLight)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: screen.width,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      screen.width /
                                                                          4;
                                                                  i++)
                                                                Container(
                                                                  width: 3,
                                                                  height: 1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: i.isEven
                                                                        ? Theme.of(context)
                                                                            .hintColor
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(2),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          itemCount: _videos.length,
                                        )
                                      : Container(
                                          width: screen.width,
                                          child: Text(
                                            "لا يوجد بيانات",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: screen.width * 0.075,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        future: to.fe(),
      )
    ]);
  }
}
