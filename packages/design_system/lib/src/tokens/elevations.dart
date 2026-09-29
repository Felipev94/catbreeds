import 'package:flutter/painting.dart';

abstract final class AppElevation {
  static const double LEVEL_0 = 0.0;
  static const double LEVEL_1 = 1.0;
  static const double LEVEL_2 = 3.0;
  static const double LEVEL_3 = 6.0;
  static const double LEVEL_4 = 10.0;
  static const double LEVEL_5 = 16.0;
}

abstract final class AppShadows {
  static const List<BoxShadow> LIGHT_LEVEL_0 = [];

  static const List<BoxShadow> LIGHT_LEVEL_1 = [
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 3),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  static const List<BoxShadow> LIGHT_LEVEL_2 = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> LIGHT_LEVEL_3 = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> LIGHT_LEVEL_4 = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> LIGHT_LEVEL_5 = [
    BoxShadow(
      color: Color(0x29000000),
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
    ),
  ];

  static const List<BoxShadow> DARK_LEVEL_0 = [];

  static const List<BoxShadow> DARK_LEVEL_1 = [
    BoxShadow(color: Color(0x33000000), offset: Offset(0, 1), blurRadius: 3),
  ];

  static const List<BoxShadow> DARK_LEVEL_2 = [
    BoxShadow(
      color: Color(0x4D000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> DARK_LEVEL_3 = [
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
  ];

  static const List<BoxShadow> DARK_LEVEL_4 = [
    BoxShadow(
      color: Color(0x80000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
  ];

  static const List<BoxShadow> DARK_LEVEL_5 = [
    BoxShadow(
      color: Color(0x99000000),
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
    ),
  ];
}
