import 'dart:async';

import 'package:delivery/common/end_points_api/api_end_points.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../Dio/Dio.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/coupon_model.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/screens/home.dart';
import '../../orders/controller/my_orders_cubit.dart';
import '../../orders/controller/my_order_data_handler.dart';
import '../../point/controller/point_cubit.dart';
import 'order_data_handler.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);

  Coupon ?couponData;
  void postCoupon({
    required String coupon,
    required int subtotal,
    required int shippingPrice,
    required BuildContext context,
  }) async {
    emit(CouponLoading());
    final result = await PostOrderDataHandler.postCoupon(
      coupon: coupon,
      shippingPrice: shippingPrice,
      subtotal: subtotal,
    );
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponNotValid.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
      Navigator.pop(context);
      emit(CouponError());
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponAddSuccessfully.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
      Navigator.pop(context);
      emit(CouponSuccess());
    });
  }
  void postOrder({
    String? coupon,
    required List items,
    required String customerNotes,
    required BuildContext context,
  }) async {
    emit(PostOrderLoading());
    final result;
    if(coupon!=null){
      result = await PostOrderDataHandler.postOrder(
        coupon: coupon,
        items: items,
        customerNotes: customerNotes,
      );
    }else{
      result = await PostOrderDataHandler.postOrder(
        items: items,
        customerNotes: customerNotes,
      );
    }

    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.failedExecuteOrder.tr(context),style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(PostOrderError());
    }, (r) {
      pageController=PageController(initialPage: 2);
      HomeCubit.get(context).changeNavigator(2);
      PointCubit.get(context).getPointsAndBalance();
      MyOrdersCubit.get(context).getCustomerOrders();
      couponData=null;
      navigateAndFinish(context,const Home());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(Strings.orderDoneSuccessfully.tr(context),
        style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      emit(PostOrderSuccess());
    });
  }
  List<bool> isCheckedList =[ true,false,false];
  bool choosePadding =true;
  void changePaymentMethod(index){
    if(index==1){isCheckedList=[false,true,false];emit(Reload());}
    else if(index==2){isCheckedList=[false,false,true];emit(Reload());}
    else {isCheckedList=[true,false,false];emit(Reload());}
    choosePadding =false;
    Timer(Duration(milliseconds: 350), () {
      choosePadding = true;
      emit(Reload());
    });
  }
}
