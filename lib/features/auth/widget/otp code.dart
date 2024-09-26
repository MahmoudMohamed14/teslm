import 'package:delivery/features/auth/controller/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';

Widget otpCode(state,otpController,pinFocusNode,country,phoneNumber,context,otp1)=>Padding(
  padding: const EdgeInsets.only(left: 10.0,right: 10),
  child: PinFieldAutoFill(
    controller: otpController,
    enabled: state is LoginOTPLoading?false : true,
    enableInteractiveSelection:false,
    focusNode: pinFocusNode,
    autoFocus:true,
    decoration: BoxLooseDecoration(
      textStyle: const TextStyle(
        color: Colors.black, // Change the text color here
        fontSize: 20.0, // Change the font size if desired
      ),
      strokeColorBuilder: PinListenColorBuilder(ThemeModel.mainColor, Colors.black),
      bgColorBuilder: const FixedColorBuilder(Colors.white),
      strokeWidth: 2,
    ),
    cursor: Cursor(color: ThemeModel.mainColor, enabled: true, width: 1),
    onCodeSubmitted: (code) {
      checkOtp(context,country,phoneNumber,otp1);
    },
    onCodeChanged: (code) {
      if(code!.length==6){
        final otpCubit = context.read<AuthCubit>();
        // otpCubit.verifyOtpCode('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7','$country$phoneNumber',_otpController.text,'c6e0d3b0-ff3b-42a7-9e37-599da8811f2f','Ar');
      }else{}
    },
    codeLength: 6,
  ),
);
Future<void> checkOtp(context,country,phoneNumber,otp1)async{
  try{
    AuthCubit.get(context).userLoginOTP(
      phoneNumber: '$country$phoneNumber',
      context: context, otp: otp1,
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
}