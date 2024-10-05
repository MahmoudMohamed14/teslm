import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/widgets/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../controller/auth_cubit.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../../widgets/app_text_widget.dart';


class OtpNumber extends StatefulWidget {
  final String phoneNumber;
  final String country;
  //String verificationID;
  const OtpNumber({super.key,required this.phoneNumber,required this.country});
  @override
  State<OtpNumber> createState() => OtpNumberState();
}

class OtpNumberState extends State<OtpNumber>  with SingleTickerProviderStateMixin{
  AnimationController? _animationController;
  int levelClock = 2 * 60;
  final FocusNode _pinFocusNode = FocusNode();
  final TextEditingController _otpController=TextEditingController();
  OtpNumberState();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _animationController!.forward();
    listenSmsCode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }
  Future<void> listenSmsCode() async {
    try {
      await SmsAutoFill().listenForCode();
    } catch (e) {}
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color:ThemeModel.of(context).greenAppBar,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(19),bottomRight:Radius.circular(19) )
              ),


            ),
          //  Image.asset(ImagesApp.codeVerity),
            PositionedDirectional(
              end: 0,
                bottom: 0,
                child: CustomFlip(child: Image.asset(ImagesApp.codeVerity),)),
            PositionedDirectional(
                start: 17.w,
                bottom: 32.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomFlip(flipX: false,child: Icon(Icons.arrow_back_ios_new,color: ThemeModel.of(context).backgroundColor,),),
                    6.w.widthBox,
                    SizedBox(
                      width: 200,
                      child: AppTextWidget(Strings.verityYourAccount.tr(context),textAlign: TextAlign.start,style:
                      TextStyleHelper.of(context).regular14.copyWith(fontSize: 25,color: ThemeModel.of(context).backgroundColor,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w700),maxLines: 2,),
                    ),
                  ],
                )),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(18.r),
          child: Column(


            children: [
              70.h.heightBox,
              Image.asset(ImagesApp.codeImage,fit: BoxFit.cover,height: 250,width: 250,),
             24.h.heightBox,
              AppTextWidget( Strings.codeYouEnteredInvalid.tr(context),style: TextStyleHelper.of(context).regular14,),
              16.h.heightBox,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: PinFieldAutoFill(
                  controller: _otpController,
                 // enabled: state is LoginOTPLoading?false : true,
                  enableInteractiveSelection:false,
                  focusNode: _pinFocusNode,
                  autoFocus:true,
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(
                      color: Colors.black, // Change the text color here
                      fontSize: 20.0, // Change the font size if desired
                    ),
                    strokeColorBuilder: PinListenColorBuilder(Colors.white, Colors.white),
                    bgColorBuilder: const FixedColorBuilder(Colors.white),
                    strokeWidth:0,
                  ),
                  cursor: Cursor(color: ThemeModel.mainColor, enabled: true, width: 1),
                  onCodeSubmitted: (code) {
                   // checkOtp(context,country,phoneNumber,_otpController);
                    AuthCubit.get(context).userLoginOTP(phoneNumber: "${widget.country}${widget.phoneNumber}", otp: _otpController.text, context: context);
                  },
                  onCodeChanged: (code) {
                    if(code?.length==6){
                      AuthCubit.get(context).userLoginOTP(phoneNumber: "${widget.country}${widget.phoneNumber}", otp: _otpController.text, context: context);
                    }
                    else{}
                  },
                  codeLength: 6,
                ),
              ),
              const SizedBox(height: 8,),
              Center(child: AppTextWidget( "didNotReceiveCode".tr(context),style: TextStyleHelper.of(context).regular14,)),
              16.h.heightBox,
              Center(child: AppTextWidget( "resendCode".tr(context)
                ,style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).primary,fontWeight: FontWeight.w900))),
              45.h.heightBox,
              BottomWidget(Strings.verity.tr(context), () async {
              },radius: 30,)
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}