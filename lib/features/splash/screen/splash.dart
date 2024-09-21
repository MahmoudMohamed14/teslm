import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/constant values.dart';
import '../../../common/images/images.dart';

class Splash extends StatefulWidget {
  Widget home;
  Splash({super.key,required this.home});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    navigateToHome();
    super.initState();
  }
  void navigateToHome()async{
    await Future.delayed(const Duration(milliseconds: 5000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => widget.home),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image(image: AssetImage(isDark??false? ImagesApp.splashDarkImage:ImagesApp.splashLightImage)),),
    );
  }
}
