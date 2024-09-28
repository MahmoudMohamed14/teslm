

import 'package:flutter/material.dart';

class CustomFlip extends StatelessWidget {
  const CustomFlip({super.key, required this.child, this.flipX=true});
 final Widget child;
 final bool flipX;
  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flipX,
      child: child,
    );
  }
}
