import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class doctor_name extends StatelessWidget {
  final _image;
  final _firstname;
  final _lastname;
  final _rate;

  const doctor_name(this._image, this._firstname, this._lastname, this._rate);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screen.width * 0.25,
          height: screen.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  fit: BoxFit.fitHeight, image: AssetImage(_image.toString()))),
        ),
        SizedBox(
          width: screen.width * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "${_firstname.toString()} ${_lastname.toString()}",
                  style: TextStyle(
                      fontSize: screen.width * 0.07,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  width: screen.width * 0.02,
                ),
                Text(
                  "(${_rate.toStringAsFixed(1)})",
                  style: TextStyle(
                      fontSize: screen.width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            SizedBox(
              height: screen.height * 0.005,
            ),
            Row(
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
                  initialRating: double.parse(_rate.toString()),
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
      ],
    );
  }
}
