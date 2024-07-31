import 'package:flutter/material.dart';

class articleCard extends StatelessWidget {
  final int _id;
  final String _title;
  final String _content;
  final String _website;
  final String _age;
  final DateTime _date;
  const articleCard(this._title, this._content, this._age, this._date,
      this._website, this._id);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return InkWell(
        onTap: () {},
        child: Column(children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(screen.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _title,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: screen.width * 0.002,
                        ),
                        Text(
                          "الناشر: $_website",
                          textDirection: TextDirection.rtl,
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: screen.width * 0.002,
                        ),
                        Text(
                          "تاريخ النشر : ${_date.day}/${_date.month}/${_date.year}",
                          textDirection: TextDirection.rtl,
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screen.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: screen.width * 0.14,
                        height: screen.width * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        child: Center(
                          child: Text(
                            _age,
                            style: TextStyle(
                                fontSize: screen.width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColorLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 3,
            color: Color.fromARGB(255, 226, 226, 226),
          ),
        ])); /* InkWell(
      onTap: () {
        Navigator.pushNamed(context, article_content.routname, arguments: {
          'id': _id,
          'content': _content,
          'title': _title,
          'website': _website,
          'age': _age,
          'date': _date
        });
      },
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: EdgeInsets.all(
                screen.width * 0.04,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "$_title",
                          softWrap: false,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: screen.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: screen.width * 0.01,
                        ),
                        Text(
                          "by : $_website",
                          softWrap: false,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: screen.width * 0.035,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 20, 20, 20)),
                        ),
                        SizedBox(
                          height: screen.width * 0.04,
                        ),
                        Text(
                          'Published in : ${_date.day}/${_date.month}/${_date.year}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: screen.width * 0.03),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screen.width * 0.05,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: screen.width * 0.14,
                          height: screen.width * 0.14,
                          child: Center(
                              child: Text(
                            "${_age}y",
                            style: TextStyle(
                                fontSize: screen.width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColorLight),
                          )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          Container(
            height: 3,
            color: Color.fromARGB(255, 226, 226, 226),
          ),
        ],
      ),
    );*/
  }
}
