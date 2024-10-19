import 'dart:convert';

import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common/colors/theme_model.dart';
import '../../../../common/components.dart';
import '../../../../widgets/newCustomTextEdit.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../controller/order_cubit.dart';



class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    OrderCubit.get(context).fromBack=false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state)  {
    if (state == AppLifecycleState.resumed && OrderCubit.get(context).fromBack)  {
      OrderCubit.get(context).getPayoutStatusById(context).then((onValue){
       /* if(response.data['status']=='paid'){
          postOrder(items: values,coupon:couponCode?.id,customerNotes: customerNotes,context: context);
        }*/
        //OrderCubit.get(context).fromBack=false;
        print("AppLifecycleState.resumed");
      });

    }
  }

  var formKey = GlobalKey<FormState>();

  TextEditingController cardNumberController = TextEditingController();

  TextEditingController expDateController = TextEditingController();

  TextEditingController cvvController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },

        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: appBarWithIcons(Strings.addPayment.tr(context),ImagesApp.addPayment,true,context),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: OrderCubit.get(context).fromBack? const Center(child: CircularProgressIndicator()):Form(
                key: formKey,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [

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
                            maxLength: 16,
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
                              final RegExp english = RegExp(r'^[a-zA-Z]+');
                              if (value == null || value.isEmpty) {
                                return Strings.cardHolderNameIsRequired.tr(context);
                              }else if(!english.hasMatch(value)){
                                return "should be English letters only".tr(context);
                              }
                              return null;
                            },
                            backGroundColor: ThemeModel.of(context).myAccountTextFieldLightColor,

                          ),
                          56.h.heightBox,

                        ],
                      ),
                    ).expand,
                    BottomWidget("${Strings.payNow.tr(context)} (${((ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice)-(OrderCubit.get(context).couponDiscount).toInt())} ${Strings.sr.tr(context)})", (){



                      if (formKey.currentState!.validate()) {
                        OrderCubit.get(context).actionPayment(context,cardNumber: cardNumberController.text, expiryMonth: '12',expiryYear: '26', name: nameController.text,total: (((ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice)-(OrderCubit.get(context).couponDiscount).toInt())*100).toInt(),cvv: cvvController.text);
                      }

                    },radius: 20,)

                  ],),
              ),
            ),
          );
        }
    );
  }
}
