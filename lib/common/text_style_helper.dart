import 'package:flutter/material.dart';
import 'colors/theme_model.dart';
class TextStyleHelper {
  final BuildContext context;
  const TextStyleHelper._(this.context);
  static TextStyleHelper of(BuildContext context) => TextStyleHelper._(context);
  TextStyle getTextStyle({required double fontSize, FontWeight? fontWeight}) =>
      TextStyle(
        fontFamily: 'Roboto',
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: ThemeModel.of(context).font1,
        height: 1.0,
      );
  TextStyle get medium24 =>
      getTextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle get regular24 =>
      getTextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  TextStyle get regular20 =>
      getTextStyle(fontSize: 20, fontWeight: FontWeight.w400);

  TextStyle get medium20 =>
      getTextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  TextStyle get medium18 =>
      getTextStyle(fontSize:18, fontWeight: FontWeight.w500);
  TextStyle get medium14 =>
      getTextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get regular16 =>
      getTextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get regular12 =>

      getTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get regular15 =>
      getTextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle get regular14 =>
      getTextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get regular10 =>
      getTextStyle(fontSize: 10, fontWeight: FontWeight.w400);
  TextStyle get bold10 =>
      getTextStyle(fontSize: 10, fontWeight: FontWeight.w700);
  TextStyle get bold12 =>
      getTextStyle(fontSize: 12, fontWeight: FontWeight.w700);
  TextStyle get bold19 =>
      getTextStyle(fontSize: 19, fontWeight: FontWeight.w700);
  TextStyle get bold20 =>
      getTextStyle(fontSize: 20, fontWeight: FontWeight.w700);
}
