import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Future<void> enterCoupon(context,couponController,bool isSaveCoupon) async {
  await showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          couponController.clear();
          return true;
        },
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            List<Widget> actions = [];
            if (state is CouponLoading) {
              actions = [
                SpinKitWave(
                  color:isDark??false? Colors.white:borderColor,
                  size: 25.0,
                )
              ];
            } else {
              actions = [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomWidget(
                      Strings.cancel.tr(context),
                      color: ThemeModel.dark().myAccountBackgroundDarkColor,
                      width: 120,
                          () {
                        Navigator.pop(context);
                        couponController.clear();
                      },
                    ),
                    BottomWidget(
                      Strings.addCoupon.tr(context),
                      width: 120,
                          isSaveCoupon?
                          (){

                          }
                              :() {
                        OrderCubit.get(context).postCoupon(
                          coupon: couponController.text,
                          subtotal: price,
                          shippingPrice: 10,
                          context: context,
                        );
                        couponController.clear();
                      },
                    ),
                  ],
                ),
              ];
            }
            return AlertDialog(
              backgroundColor: ThemeModel.of(context).cardsColor,
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width/1.2,
                height: 130.h,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ImagesApp.couponImage,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextField(
                      autofocus: true,
                      controller: couponController,
                      decoration: InputDecoration(
                        hintText: 'Htss1254',
                      ),
                    ),
                  ],
                ),
              ),
              actions: actions,
            );
          },
        ),
      );
    },
  );
}