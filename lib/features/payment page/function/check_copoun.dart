import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';

Future<void> enterCoupon(context,couponController) async {
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
                BottomWidget(
                  language == 'English Language' ? 'Add' : 'اضافه',
                      () {
                    OrderCubit.get(context).postCoupon(
                      coupon: couponController.text,
                      subtotal: price,
                      shippingPrice: 10,
                      context: context,
                    );
                    couponController.clear();
                  },
                )
              ];
            }
            return AlertDialog(
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width/1.2,
                child: TextField(
                  autofocus: true,
                  controller: couponController,
                  decoration: InputDecoration(
                    hintText: language=='English Language'?'Enter coupon code':"اضف الكوبون",
                  ),
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