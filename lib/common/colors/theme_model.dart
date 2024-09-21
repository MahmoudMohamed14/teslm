import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


import '../../Cubite/them/app_dark_light_cubit.dart';


class ThemeModel {
  static ThemeModel of(BuildContext context) =>
      AppDarkLightCubit.get(context).isDark
          ? ThemeModel.dark()
          : ThemeModel.light();
  static ThemeModel get defaultTheme {
    Brightness brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark
        ? ThemeModel.dark()
        : ThemeModel.light();
  }

  static const constFont1 = Color(0xFFF0F0F2);
  final Color primary;
  final Color backgroundColor;
  final Color blackWhiteColor;
  final Color card;
  final Color subCard;
  final Color subCard2;
  final Color textMainColor;
  final Color font1;
  final Color font2;
  final Color font3;
  final Color font4;
  final Color additional;
  final Color danger;
  final Color blue2;
  final Color iconBackgroundColor;
  final Color successColor;
  final Color red;
  final Color greenAppBar;
  ThemeModel.light( {
    this.primary = const Color(0xffF78C2E),
    this.greenAppBar= const Color(0xff33C072),
    this.backgroundColor = const Color(0xffFCFFFF),
    this.blackWhiteColor = const Color(0xff000000),
    this.textMainColor = const Color(0xff1F1F1F),
    this.card = const Color(0xFFF6F8F8),
    this.subCard = const Color(0xFFE7EBED),
    this.subCard2 = const Color(0xFFD8DCE5),
    this.font1 = const Color(0xFF0E111A),
    this.font2 = const Color(0xFF878787),
    this.font3 = const Color(0xFFC5C5C5),
    this.font4 = const Color(0xFFE5E5E5),
    this.additional = const Color(0xFFE0BC85),
    this.danger = const Color(0xFFF04940),
    this.blue2 = const Color(0xFF02A9C9),
    this.iconBackgroundColor = const Color(0xFF53AE94),
    this.successColor = const Color(0xFF6FCF97),
    this.red = const Color(0xFFEB5757),
  }); // Safety check

  ThemeModel.dark({
    this.primary = const Color(0xff3C9AA6),
    this.greenAppBar= const Color(0xff33C072),
    this.backgroundColor = const Color(0xffFCFFFF),
    this.blackWhiteColor = const Color(0xffffffff),
    this.textMainColor = const Color(0xfff1f1f1),
    this.card = const Color(0xFF1B1E28),
    this.subCard = const Color(0xFF272A35),
    this.subCard2 = const Color(0xFF353945),
    this.font1 = const Color(0xFFF0F0F2),
    this.font2 = const Color(0xFFB6BDC7),
    this.font3 = const Color(0xFF97A1AD),
    this.font4 = const Color(0xFF71757F),
    this.additional = const Color(0xFFE0BC85),
    this.danger = const Color(0xFFF04940),
    this.blue2 = const Color(0xFF2D9CDB),
    this.iconBackgroundColor = const Color(0xFF53AE94),
    this.successColor = const Color(0xFF6FCF97),
    this.red = const Color(0xFFEB5757),
  }); // Safety check
}
