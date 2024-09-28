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
  String phoneNumber;
  String country;
  //String verificationID;
  OtpNumber({super.key,required this.phoneNumber,required this.country});
  @override
  State<OtpNumber> createState() => OtpNumberState(phoneNumber: phoneNumber, country: country);
}

class OtpNumberState extends State<OtpNumber>  with SingleTickerProviderStateMixin{
  String phoneNumber;
  String country;
  AnimationController? _animationController;
  int levelClock = 2 * 60;
  final FocusNode _pinFocusNode = FocusNode();
  final TextEditingController _otpController=TextEditingController();
  OtpNumberState({required this.phoneNumber,required this.country});
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
 /* Future<void> checkOtp()async{
    try{
      DeliveryCubit.get(context).userLoginOTP(
        phoneNumber: '$country$phoneNumber',
        context: context, otp: _otpController.text.trim(),
      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(language=='English Language'?"OTP entered is not valid":'الكود المدخل ليس صحيح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      print(e.toString());
    }
  }*/
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
  listener: (context, state) {
   /* if (state is OtpVerifySuccess) {
      DeliveryCubit.get(context).userLoginOTP(
        phoneNumber: '$country$phoneNumber',
        context: context, otp: _otpController.text.trim(),
      );
      DeliveryCubit.get(context).getPointsCustomer();
      DeliveryCubit.get(context).getCouponsData();
    } else if (state is OtpVerifyFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(language=='English Language'?"OTP entered is not valid":'الكود المدخل ليس صحيح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
    }*/
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
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
                    CustomFlip(child: Icon(Icons.arrow_back_ios_new,color: ThemeModel.of(context).backgroundColor,),flipX: false,),
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
               /*Text(
                language=='English Language'?"Verification":"تحقق من رقمك",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child:  Text(
                  language=='English Language'?"Enter the code sent to your number":'ادخل الكود المرسل لهاتفك',
                  style: TextStyle(
                    color: isDark??false? Colors.white:Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  '+$country *******${phoneNumber[7]}${phoneNumber[8]}',
                  style:const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              */

             // otpCode(state,_otpController,_pinFocusNode,country,phoneNumber,context,_otpController.text.trim()),
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
                    AuthCubit.get(context).userLoginOTP(phoneNumber: "$country$phoneNumber", otp: _otpController.text, context: context);
                  },
                  onCodeChanged: (code) {
                    if(code?.length==6){
                     /* final otpCubit = context.read<DeliveryCubit>();
                      // otpCubit.verifyOtpCode('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7','$country$phoneNumber',_otpController.text,'c6e0d3b0-ff3b-42a7-9e37-599da8811f2f','Ar');
               */
                      AuthCubit.get(context).userLoginOTP(phoneNumber: "$country$phoneNumber", otp: _otpController.text, context: context);
                    }
                    else{}
                  },
                  codeLength: 6,
                ),
              ),
              const SizedBox(height: 8,),
           /*   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(language=='English Language'?"No get message: ":'لم تصلك رساله'),
                  _animationController!.value == 0?Countdown(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_animationController!),
                  ):InkWell(onTap: (){}, child: Text(language=='English Language'?'Resnd Code':'اعارة الارسال',style: TextStyle(color: mainColor),)),
                ],
              ),*/
              Center(child: AppTextWidget( "didNotReceiveCode".tr(context),style: TextStyleHelper.of(context).regular14,)),
              16.h.heightBox,
              Center(child: AppTextWidget( "resendCode".tr(context)
                ,style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).primary,fontWeight: FontWeight.w900))),
              45.h.heightBox,
              bottom(Strings.verity.tr(context), () async {


              },radius: 30,)
             /* if (state is OtpCheckLoading)
               const Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CircularProgressIndicator(),
                )*/
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
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

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