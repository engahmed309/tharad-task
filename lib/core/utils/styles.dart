import 'package:flutter/material.dart';

import 'constants.dart';

abstract class Styles {
  static const textStyle10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    fontFamily: 'Tajawal',
    color: kTextColor,
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'Tajawal',

    color: kTextColor,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
    color: kTextColor,
  );

  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontFamily: 'Tajawal',

    fontWeight: FontWeight.w600,
    color: kTextColor,
  );

  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontFamily: 'Tajawal',

    fontWeight: FontWeight.bold,
    color: kTextColor,
  );

  static const textStyle22 = TextStyle(
    fontSize: 22,
    fontFamily: 'Tajawal',

    fontWeight: FontWeight.bold,
    color: kTextColor,
  );

  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontFamily: 'Tajawal',

    fontWeight: FontWeight.bold,
    color: kTextColor,
  );
}

const TextStyle defaultTextStyle = TextStyle(color: kTextColor, fontSize: 16);
