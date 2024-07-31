import 'package:flutter/material.dart';
import 'package:version_1/screens/doctors/review_item.dart';

class review_card extends StatelessWidget {
  final review;
  const review_card(this.review);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screen.width * 0.02),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الاّراء:",
                style: TextStyle(
                    fontSize: screen.width * 0.065,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColorLight),
              ),
              Card(
                color: Color.fromARGB(255, 235, 234, 234),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Color.fromARGB(255, 167, 166, 166),
                    width: 1.0,
                  ),
                ),
                borderOnForeground: false,
                shadowColor: Theme.of(context).primaryColorLight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    height: review.length > 2
                        ? 2 * screen.height * 0.350
                        : review.length > 1
                            ? review.length * screen.height * 0.27
                            : review.length * screen.height * 0.3,
                    child: InkWell(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              review_item(
                                  review[index]['content'] == null
                                      ? ""
                                      : review[index]['content'],
                                  review[index]['rating'],
                                  review[index]['review_writer_name'],
                                  review[index]['publish_date']),
                              Divider(
                                color: Color.fromARGB(255, 207, 207, 207),
                                endIndent: 20,
                                indent: 20,
                                thickness: 1,
                              ),
                            ],
                          );
                        },
                        itemCount: review.length,
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
