

import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Cubite/material_cubit/auth_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';

import '../widget/phone_field_widget.dart';

import 'otp number.dart';

class Login extends StatefulWidget {
  const Login({super.key,this.fromOrder=false});
  final bool fromOrder;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String countryCode='966';
  var formKey=GlobalKey<FormState>();
  TextEditingController numberController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        /*if (state is OtpSentSuccess) {
          if(numberController.text.isNotEmpty)
          {
            if(numberController.text.startsWith('5')&&numberController.text.length==9){
              navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(language=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح",
                style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white) ,)),backgroundColor: Colors.red.shade300,),);
            }
          }
        }else if (state is LoginOTPError) {
          // Handle failure, like showing an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }*/
      },
      builder: (context, state) {
        return SafeArea(

          child: Scaffold(

            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: 50.h,),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 88,
                              width: 88,
                              decoration:const BoxDecoration(
                                  color: colorD9D9D9,
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: SvgPicture.asset(widget.fromOrder?ImagesApp.salaIcon:ImagesApp.pointerIcon),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text(widget.fromOrder?Strings.youDontOrder.tr(context):Strings.youDontPointer.tr(context),style:const TextStyle(fontFamily: 'Roboto',fontSize: 20,fontWeight: FontWeight.w700,),textAlign: TextAlign.center,),
                            const SizedBox(height: 7,),
                            Text(Strings.pleaseAddYourPhone.tr(context),style:const TextStyle(fontFamily: 'Roboto',fontSize: 14,fontWeight: FontWeight.w500,color: color747581),),
                          ],
                        ),
                      ),
                   SizedBox(height: 50.h,),


                     // Text(Strings.phoneNumber.tr(context),style:const TextStyle(fontFamily: 'Roboto',fontSize: 14,fontWeight: FontWeight.w300),),
                     // const SizedBox(height: 6,),
                   PhoneFieldWidget(isError: false,controller: numberController,title: Strings.phoneNumber.tr(context),onCountryChanged: (code){
                          countryCode=code.fullCountryCode;
                                 },validator:(value){
                     
                    return "enterValidPhoneNumber".tr(context);
                     } ,),

                      const SizedBox(height: 20,),
                      state is LoginLoading? const Center(child: CircularProgressIndicator()):    bottom(Strings.continueText.tr(context), () async {
                       // navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
                        if(numberController.text.startsWith('5')&&numberController.text.length==9){
                          final otpCubit = context.read<AuthCubit>();
                          print(countryCode+numberController.text);
                          otpCubit.userLogin(phoneNumber:numberController.text,code: countryCode,context:context);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("enterValidPhoneNumber".tr(context),
                            style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white) ,)),backgroundColor: Colors.red.shade300,),);
                        }
                      },radius: 30,)
                  
                    ],
                  ),
                ),
              ),
            ),
            /*Center(
          child: Container(
            height:220,
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: isDark??false? Colors.black12:Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1),
                      blurRadius: 20, spreadRadius: 5),]),
            child: Column(
              children: [
                buildSignupSection(countryCode,numberController), const Spacer(),

                state is OtpSending? const CircularProgressIndicator():bottom(language=='English Language'?'Continue':'متابعه',()async{
             *//*     final otpCubit = context.read<DeliveryCubit>();
                  await otpCubit.addSender('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7', 'mostafa101', 'Base64EncodedFileString');
                  await otpCubit.inquireSenders('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7');
                  await otpCubit.sendOtpMessage('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7', '$countryCode${numberController.text}', 'Ar', 'YourRegisteredSenderID');
                  otpCubit.generateOtp();
                  otpCubit.sendOtpMessage('mostafa1021999', 'D0A33FB434111DFE02585FF2394D3AB7', '$countryCode${numberController.text}','c6e0d3b0-ff3b-42a7-9e37-599da8811f2f','Ar');*//*
                  navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode, verificationID: '123456',));
                })
              ],
            ),
          ),
        ),*/
          ),
        );
      },
    );
  }
  Future<void> sendOTP()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    print('+$countryCode${numberController.text}');
    await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber: '+$countryCode${numberController.text}',
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        codeSent: (String verificationId, int? resendToken) {
        //  DeliveryCubit.get(context).userLogin(phoneNumber: numberController.text, code: countryCode,context:context );
          if(numberController.text.isNotEmpty)
          {
            if(numberController.text.startsWith('5')&&numberController.text.length==9){
              navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text(language=='English Language'?'Enter Valid phone number':"ادخل رقم هاتف صحيح",
                style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white) ,)),backgroundColor: Colors.red.shade300,),);
            }
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {  }
    );
  }
}

