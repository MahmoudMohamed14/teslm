import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/colors/colors.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../controller/auth_cubit.dart';
import '../widget/phone_field_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.fromOrder = false});
  final bool fromOrder;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String countryCode = '966';
  var formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
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
                      SizedBox(
                        height: 50.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 88,
                              width: 88,
                              decoration: const BoxDecoration(
                                  color: colorD9D9D9, shape: BoxShape.circle),
                              child: Center(
                                child: SvgPicture.asset(widget.fromOrder
                                    ? ImagesApp.salaIcon
                                    : ImagesApp.pointerIcon),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.fromOrder
                                  ? Strings.youDontOrder.tr(context)
                                  : Strings.youDontPointer.tr(context),
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              Strings.pleaseAddYourPhone.tr(context),
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeModel.of(context).font2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      PhoneFieldWidget(
                        isError: false,
                        controller: numberController,
                        backGroundColor: ThemeModel.of(context).cardsColor,
                        title: Strings.phoneNumber.tr(context),
                        onCountryChanged: (code) {
                          countryCode = code.fullCountryCode;
                        },
                        validator: (value) {
                          debugPrint("Here........>>>>  $value");
                          return "enterValidPhoneNumber".tr(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is LoginLoading
                          ? const Center(child: CircularProgressIndicator())
                          : bottom(
                              Strings.continueText.tr(context),
                              () async {
                                // navigate(context, OtpNumber(phoneNumber: numberController.text, country: countryCode,));
                                if (numberController.text.startsWith('5') &&
                                    numberController.text.length == 9) {
                                  final otpCubit = context.read<AuthCubit>();
                                  print(countryCode + numberController.text);
                                  otpCubit.userLogin(
                                      phoneNumber: numberController.text,
                                      code: countryCode,
                                      context: context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                          child: Text(
                                        "enterValidPhoneNumber".tr(context),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )),
                                      backgroundColor: Colors.red.shade500,
                                    ),
                                  );
                                }
                              },
                              radius: 30,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
