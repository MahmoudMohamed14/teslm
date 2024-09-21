import 'package:flutter/material.dart';

import '../common/text_style_helper.dart';


class AppTextWidget extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  const AppTextWidget(this.text,
      {super.key, this.style, this.maxLines, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      style: style??TextStyleHelper.of(context).regular20,
    );
  }
}
