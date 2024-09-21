import 'package:delivery/common/colors/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/onboarding_body.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: floatActionColor,
      body: onBoardingBody(context,currentPage,(value){
        setState(() {
          currentPage=value;
        });
      }),
    );
  }
}
