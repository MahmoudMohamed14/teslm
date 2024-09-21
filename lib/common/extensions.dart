
import 'package:flutter/material.dart';



extension WidgetsExtensions on Widget {
  Widget align(AlignmentDirectional position) => Align(
        alignment: position,
        child: this,
      );
  Widget get expand => Expanded(child: this);
  Widget expandFlex(int flex) => Expanded(flex: flex, child: this);
  Widget paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: this,
      );
  Widget paddingAll({double padding = 0.0}) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );
  Widget paddingOnly({
    double start = 0.0,
    double end = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
            start: start, end: end, top: top, bottom: bottom),
        child: this,
      );
}

extension MapExtensions on Map {
  Map<String, String> dynamicMapToString() {
    Map<String, String> body = {};
    forEach((key, value) {
      if (value is List) {
        body.addAll(_mapListValueHandler(key, value));
      } else if (value is Map) {
        body.addAll(value.dynamicMapToString());
      } else if (value is DateTime) {
        body[key] = value.toIso8601String();
      } else if (value != null) {
        body[key] = value.toString();
      }
    });
    return body;
  }

  Map<String, String> _mapListValueHandler(String key, List iterator) {
    Map<String, String> result = {};
    for (var item in iterator) {
      result["$key[${iterator.indexOf(item)}]"] = item.toString();
    }
    return result;
  }
}

extension DoubleExtensions on double {
  Widget get heightBox => SizedBox(height: this);
  Widget get widthBox => SizedBox(width: this);
}

extension DateTimeExtensions on DateTime {
  String get amOrPm {
    return hour >= 12 ? "pm" : "am";
  }
}
