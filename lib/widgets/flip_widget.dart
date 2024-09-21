

import 'package:flutter/material.dart';

class CustomFlip extends StatelessWidget {
  const CustomFlip({super.key, required this.widget, this.flipX=true});
 final Widget widget;
 final bool flipX;
  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flipX,
      child: widget,
    );
  }
}
