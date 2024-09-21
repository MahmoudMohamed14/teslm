import 'package:bloc/bloc.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/translate/applocal.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../Dio/Dio.dart';
import '../../common/colors/theme_model.dart';
import '../../common/components.dart';
import '../../common/constant values.dart';
import '../../common/images/images.dart';
import '../../common/text_style_helper.dart';
import '../../common/translate/strings.dart';
import '../../features/auth/screen/otp number.dart';
import '../../features/home/screens/home.dart';
import '../../features/payment page/screen/payment.dart';
import '../../models/login model.dart';
import '../../models/otpModel.dart';
import '../../shared prefernace/shared preferance.dart';
import '../../widgets/app_text_widget.dart';
import '../delivery_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  LoginUser ?loginUser;
  void userLogin({
    required String phoneNumber,
    required String code,
    required BuildContext context,
  }){
    emit(LoginLoading());
    DioHelper.postData(url: 'customers/generate-otp', data: {
      'phoneNumber' : "$code${phoneNumber}",
    }).then((value) {
      loginUser= LoginUser.fromJson(value.data);
      navigate(context, OtpNumber(phoneNumber: phoneNumber, country: code,));
      emit(LoginSuccess());
      print("Done ${phoneNumber}");
    }).catchError((error) {
      print('error=============');
      emit(LoginError(error.toString()));
    });
  }
  LoginOTP ?loginOTP;
  void userLoginOTP({
    required String phoneNumber,
    required String otp,
    required context
  }){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/verify-otp', data: {
      'otp':otp,
      'phoneNumber' : phoneNumber,
    }).then((value)
    async{

      print("Succussfull");
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      DeliveryCubit.get(context). changeNavigator(3);
      customerId=loginOTP!.id;
      Save.savedata(key: 'customerId',value:loginOTP!.id).then((value){
        DeliveryCubit.get(context). getPointsCustomer();
        DeliveryCubit.get(context). getCouponsData();
        DeliveryCubit.get(context). getPointsAndBalance();
      }) ;
      Save.savedata(key: 'token', value: token).then((value){
        loginFromCart? navigate(context, Payment(customerNotes: '')): navigateAndFinish(context,const Home());
      });
      DeliveryCubit.get(context).getCustomerOrders();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(language=='English Language'?"Login successfully":'تم تسجيل الدخول بنجاح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(LoginOTPSuccess());
    }).catchError((error) {
      if(otp.length==6){
        showDialogHelper(context,contentWidget:
        Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset(ImagesApp.messageCode,fit: BoxFit.cover,height: 120.h,width: 130.w,),
            16.h.heightBox,
            AppTextWidget( Strings.codeYouEnteredInvalid.tr(context),style: TextStyleHelper.of(context).regular14,),
            5.h.heightBox,
            Center(child: AppTextWidget( Strings.resendCode.tr(context)
                ,style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).primary,fontWeight: FontWeight.w900))),

          ],
        ),);
      }
      print('eeeeeeeeeeeeeeeeeeeeee ${error.toString()}');
      emit(LoginOTPError(error:error.toString() ));
    });
  }
}
