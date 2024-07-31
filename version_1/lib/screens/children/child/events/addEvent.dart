import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:version_1/model/eventTypesDet.dart';
import 'package:version_1/screens/children/child/events/addEventsDetails.dart';

class addEvent extends StatelessWidget {
  static const routname = 'addEvent';

  addEvent({super.key});
  final _types = types;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          backgroundColor: Theme.of(context).primaryColorLight,
          centerTitle: true,
          title: Text(
            "إضافة حدث",
            style: TextStyle(
                fontSize: screen.width * 0.06,
                color: Theme.of(context).primaryColorDark),
          )),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
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
            Container(
              height: screen.height,
              padding: EdgeInsets.all(screen.width * 0.08),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                addEventDetails.routname,
                                arguments: {'type': index}),
                            child: Container(
                              height: screen.width * 0.1,
                              width: screen.width * 0.1,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color.fromARGB(255, 124, 124, 124),
                                    blurRadius: 6,
                                    blurStyle: BlurStyle.normal,
                                    spreadRadius: 3,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: SvgPicture.asset(
                                  _types[index]!.image.toString()),
                            ),
                          );
                        },
                        itemCount: _types.length,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
