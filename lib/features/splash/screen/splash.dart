import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/constant/constant values.dart';
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
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Color(0xFF33C072),Color(0xFF545461),],
            begin: Alignment.topCenter, // Start the gradient at the top
            end: Alignment.bottomCenter,
        )),
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                ImagesApp.backgroundImageSplash,
                height: 600,
                width:double.infinity,// You can set width and height as needed
              ),
            ),
            Center(
              child: SvgPicture.asset(
                ImagesApp.circleImageSplash,
                height: 350,
                width: 700,
              ),
            ),
            Center(child: Image(image: AssetImage(ImagesApp.splashDarkImage)),),
          ],
        ),
      ),
    );
  }
}
