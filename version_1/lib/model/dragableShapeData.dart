// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class itemdata {
  final String name;
  final Widget stroke;
  final Widget fill;

  itemdata(this.name, this.stroke, this.fill);
}

List<itemdata> itemList = [
  itemdata(
    "square",
    SvgPicture.asset(
      "assets/shapes/squareStroke.svg",
      color: Color.fromARGB(255, 112, 13, 148),
      height: 200,
      width: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/square.svg",
      color: Color.fromARGB(255, 112, 13, 148),
      height: 200,
      width: 200,
    ),
  ),
  itemdata(
    "circle",
    Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 248, 129, 252)),
          shape: BoxShape.circle),
    ),
    Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 129, 252), shape: BoxShape.circle),
    ),
  ),
  itemdata(
    "heart",
    SvgPicture.asset(
      "assets/shapes/heartStroke.svg",
      color: Color.fromARGB(255, 195, 18, 18),
      height: 200,
      width: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/heart.svg",
      color: Color.fromARGB(255, 195, 18, 18),
      height: 200,
      width: 200,
    ),
  ),
  itemdata(
    "star",
    SvgPicture.asset(
      "assets/shapes/starStroke.svg",
      color: Color.fromARGB(255, 0, 0, 0),
      height: 200,
      width: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/star.svg",
      color: Color.fromARGB(255, 0, 0, 0),
      height: 200,
      width: 200,
    ),
  ),
  itemdata(
    "triangle",
    SvgPicture.asset(
      "assets/shapes/triangleStroke.svg",
      color: Color.fromARGB(255, 188, 93, 41),
      height: 200,
      width: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/triangle.svg",
      color: Color.fromARGB(255, 188, 93, 41),
      height: 200,
      width: 200,
    ),
  ),
  itemdata(
    "hexagon",
    SvgPicture.asset(
      "assets/shapes/hexagonStroke.svg",
      color: Color.fromARGB(255, 29, 20, 159),
      height: 200,
      width: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/hexagon.svg",
      color: Color.fromARGB(255, 29, 20, 159),
      height: 200,
      width: 200,
    ),
  ),
  itemdata(
    "rectangle",
    SvgPicture.asset(
      "assets/shapes/rectangleStroke.svg",
      color: Color.fromARGB(255, 62, 184, 64),
      height: 200,
    ),
    SvgPicture.asset(
      "assets/shapes/rectangle.svg",
      color: Color.fromARGB(255, 62, 184, 64),
      height: 200,
    ),
  ),
];
