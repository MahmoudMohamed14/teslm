import 'package:flutter/cupertino.dart';

enum PageTransitionType { downToUp }

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;

  PageTransition({
    required this.child,
    required this.type,
    RouteSettings? settings,
  }) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return child;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      switch (type) {
        case PageTransitionType.downToUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        default:
          return child;
      }
    },
    transitionDuration: const Duration(milliseconds: 200),
    settings: settings,
  );
}