import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class review_item extends StatelessWidget {
  final String content;
  final rating;
  final name;
  final date;
  const review_item(this.content, this.rating, this.name, this.date);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize: screen.width * 0.04,
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (rating != Null)
                      RatingBar.builder(
                        textDirection: TextDirection.ltr,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        ignoreGestures: true,
                        allowHalfRating: true,
                        updateOnDrag: false,
                        unratedColor: Colors.grey[600],
                        minRating: 0,
                        initialRating: double.parse(rating.toString()),
                        itemSize: 16,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.zero,
                        onRatingUpdate: (double value) {},
                      ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          content,
                          style: TextStyle(
                              fontSize: screen.width * 0.042,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$date",
                      style: TextStyle(
                          fontSize: screen.width * 0.035,
                          color: Color.fromARGB(255, 120, 119, 119),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
