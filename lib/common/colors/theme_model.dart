import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../shared_preference/shared preference.dart';


class ThemeModel {
  static ThemeModel of(BuildContext context) =>
      Save.getdata(key: 'isDark')??false
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
  static const mainColor = Color(0xFFF78C2E);
  static const filterColor = Color(0xFFE1E1E1);
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
  final Color cardsColor;
  final Color myAccountTextFieldLightColor;
  final Color chatTextField;
  final Color alwaysWhitColor;
  final Color pointBigCardColor;
  final Color pointSmallCardColor;
  final Color pendingColor;
  final Color iconMainColor;
  final Color bottomNavigationBarColor;
  final Color bigCardBottomColor;
  final Color myAccountBackgroundDarkColor;
  final Color smallCardIconsColor;
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
    this.cardsColor =const Color(0xFFFFFFFF),
    this.myAccountTextFieldLightColor =const  Color(0xFFEBEBEB),
    this.chatTextField =Colors.black12,
    this.alwaysWhitColor =const Color(0xFFFFFFFF),
    this.pointBigCardColor =const Color(0xFFFFFFFF),
    this.pointSmallCardColor =const Color(0x6BD9D9D9),
    this.pendingColor =const Color(0xFFEAEAEA),
    this.iconMainColor =const Color(0xFFF78C2E),
    this.bottomNavigationBarColor =const Color(0xFFFFFFFF),
    this.bigCardBottomColor =const Color(0xFFF1F1F1),
    this.myAccountBackgroundDarkColor =const Color(0xFFFFFFFF),
    this.smallCardIconsColor =const Color(0xFF5B5B5B),

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
    this.cardsColor =const Color(0xFF33333B),
    this.myAccountTextFieldLightColor =const  Color(0xFF33333B),
    this.chatTextField =const  Color(0xFF33333B),
    this.alwaysWhitColor =const Color(0xFFFFFFFF),
    this.pointBigCardColor =const Color(0xFF4F4F5C),
    this.pointSmallCardColor =const Color(0xFF33333B),
    this.pendingColor =const Color(0xFF545260),
    this.iconMainColor =const Color(0xFFF78C2E),
    this.bottomNavigationBarColor =const Color(0xFF393A4A),
    this.bigCardBottomColor =const Color(0xFF393A4A),
    this.myAccountBackgroundDarkColor =const Color(0xFF4F4F5C),
    this.smallCardIconsColor =const Color(0xFFFFFFFF),
  }); // Safety check
}
