import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:version_1/screens/doctors/doctor_info.dart';

class doctorCard extends StatelessWidget {
  final int _id;
  final String _name;
  final String _address;
  final double _rate;
  final bool _male;
  late String _image;
  final String _profession;
  doctorCard(this._name, this._address, this._profession, this._male,
      this._rate, this._id) {
    if (_male) {
      _image = "male.png";
    } else {
      _image = "female.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Container(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Column(children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(screen.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screen.width * 0.14,
                      height: screen.width * 0.14,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(_image))),
                    ),
                  ],
                ),
                SizedBox(
                  width: screen.width * 0.05,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: TextStyle(
                            fontSize: screen.width * 0.055,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: screen.width * 0.002,
                      ),
                      Text(
                        "$_profession",
                        style: TextStyle(color: Colors.grey[800], fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: screen.width * 0.002,
                      ),
                      Text(
                        "$_address",
                        style: TextStyle(color: Colors.grey[800], fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: screen.width * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            ignoreGestures: true,
                            allowHalfRating: true,
                            updateOnDrag: false,
                            unratedColor: Colors.grey[600],
                            minRating: 1,
                            initialRating: _rate,
                            itemSize: 16,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.zero,
                            onRatingUpdate: (double value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: screen.width * 0.005,
                          style: BorderStyle.solid),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(screen.width * 0.1, 24),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, doctor_info.routname, arguments: {
                    'id': _id,
                    'image': _image,
                    'rate': _rate,
                    'name': _name
                  }),
                  child: Text(
                    "تفاصيل",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 3,
          color: Color.fromARGB(255, 226, 226, 226),
        ),
      ]),
    ));
  }
}
