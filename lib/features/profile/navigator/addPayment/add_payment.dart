import 'dart:convert';

import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../../../common/colors/theme_model.dart';
import '../../../../common/components.dart';
import '../../../../common/text_style_helper.dart';
import '../../../../widgets/app_text_widget.dart';
import '../../../../widgets/credit_card_widget.dart';
import '../../../../widgets/newCustomTextEdit.dart';



class AddPayment extends StatelessWidget {
   AddPayment({super.key});
  var formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: AppTextWidget(Strings.addPaymentName.tr(context), style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1,),textAlign: TextAlign.center,)),
          32.h.heightBox,
            Swiper(
              itemWidth: double.infinity,
                itemHeight: 255,
                loop: true,
                duration: 500,
                scrollDirection: Axis.horizontal,
                layout: SwiperLayout.TINDER,
                itemBuilder: (context, index) {
                  return CreditCardWidget(id: index,);
                },
                itemCount: 1
            ),

          32.h.heightBox,
            SingleChildScrollView(
              child: Column(
                children: [
                  NewCustomTextEdited(enable: true,borderRadiusValue: 20.r,prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(ImagesApp.cardNumber),

                            ),
                  title: Strings.cardNumber.tr(context),

                  hint: '0000 0000 0000 0000',
                  textInputType: TextInputType.number,
                  controller: cardNumberController,
                  backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings.cartNumberIsRequired.tr(context);
                      } else if (value.length != 16) {
                        return Strings.cartNumberMustBe16Digits.tr(context);
                      }
                      return null;
                    },

                            ),
                  16.h.heightBox,
                  Row(children: [
                    NewCustomTextEdited(enable: true,borderRadiusValue: 20.r,prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(ImagesApp.calendar),

                    ),
                      title: Strings.expiryDate.tr(context),
                      controller: expDateController,
                      hint: 'MM/YY',
                     // maxLength: 5,
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.expiryDateIsRequired.tr(context);
                        }
                        final regex = RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$");
                        if (!regex.hasMatch(value)) {
                          return Strings.enterValidExpiryDate.tr(context);
                        }
                        final parts = value.split('/');
                        final month = int.parse(parts[0]);
                        final year = int.parse('20${parts[1]}'); // Convert 'YY' to 'YYYY'

                        // Get the current month and year
                        final now = DateTime.now();
                        final currentMonth = now.month;
                        final currentYear = now.year;

                        // Check if the card is expired
                        if (year < currentYear || (year == currentYear && month < currentMonth)) {
                          return Strings.cardIsExpired.tr(context);
                        }
                        return null;
                      },

                      backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,


                    ).expand,
                    16.w.widthBox,
                    NewCustomTextEdited(enable: true,borderRadiusValue: 20.r,prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(ImagesApp.cardCvv),

                    ),
                      title: Strings.cvv.tr(context),
                      controller: cvvController,
                      hint: '123',
                      textInputType: TextInputType.number,
                      backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.cvvIsRequired.tr(context);
                        } else if (value.length < 3 || value.length > 4) {
                          return Strings.cvvMustBe3Or4Digits.tr(context);
                        }
                        return null;
                      },

                    ).expand,
                  ],),
                  16.h.heightBox,
                  NewCustomTextEdited(enable: true,borderRadiusValue: 20.r,prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(ImagesApp.person),

                  ),
                    title: Strings.cardHolderName.tr(context),

                    hint: Strings.cardHolderName.tr(context),
                    controller: nameController,
                    textInputType: TextInputType.text,
                    validator: (value) {
                     if (value == null || value.isEmpty) {
                         return 'Cardholder name is required';
                              }
                      return null;
                           },
                    backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,

                  ),
                             56.h.heightBox,

                ],
              ),
            ).expand,
            BottomWidget(Strings.save.tr(context), (){



              if (formKey.currentState!.validate()) {
                // Save or submit payment details
              }
        
            },radius: 20,)
        
        ],),
      ),
    );
  }
   /*Future<void> createPayment() async {
     final dio = Dio();

     // API URL
     const url = 'https://api.moyasar.com/v1/payments';

     // Base64-encoded authorization key
     const apiKey = 'pk_test_Z9MJdDVC96N12UzYPUgdkLREmQJHCmHdjZzY5EZm';
     final encodedApiKey = base64Encode(utf8.encode(apiKey));

     // Request headers
     final headers = {
       'Content-Type': 'application/json',
       'Authorization': 'Basic $encodedApiKey',
     };

     // Request body
     final data = {
       "amount": 600,
       "currency": "SAR",
       "description": "Payment for order #123456789",
       "callback_url": "https://example.com/thankyou",
       "source": {
         "type": "creditcard",
         "name": "mahmoud mohamed",
         "number": "4201320111111010",
         "cvc": "123",
         "month": "12",
         "year": "26"
       }

     };

     try {
       // Sending POST request using Dio
       final response = await dio.post(
         url,
         data: data,
         options: Options(headers: headers),
       );

       if (response.statusCode == 200) {
         print('Payment Successful: ${response.data}');
       } else {
         print('Payment Failed: ${response.statusCode}');
         print(response.data);
       }
     } on DioError catch (e) {
       print('Dio Error: ${e.message}');
       if (e.response != null) {
         print('Error Data: ${e.response?.data}');
       }
     } catch (e) {
       print('Unexpected Error: $e');
     }
   }*/
}
