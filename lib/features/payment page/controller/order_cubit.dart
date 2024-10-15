import 'dart:async';
import 'dart:convert';

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
import '../../profile/navigator/my_coupons/Models/get_coupons_model.dart';
import '../../provider page/controller/provider_cubit.dart';
import 'order_data_handler.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);

  double shippingPrice=15;
  double couponDiscount=0.0;
  bool isShippingDiscount=false;

  CouponData?couponCode;
void getCoupon(BuildContext context, {CouponData ?value}) async {
  couponDiscount=0.0;
  isShippingDiscount=false;
  shippingPrice=15;
  double totalPrice=ProviderCubit.get(context).getPrice()+shippingPrice;
  if(value?.appliedOn.toLowerCase()=='order'){
  if((value?.minAmount??0)<totalPrice){
    if((value?.type.toLowerCase()??'')=='percentage'){
      if(totalPrice*((value?.percentageAmount??1)/100)>(value?.maxAmount??0)){
        couponDiscount=value?.maxAmount??0;
      }else{
        couponDiscount=totalPrice*(((value?.percentageAmount??1)/100));
      }

    }else{
      couponDiscount=value?.fixedAmount??0;

    }

    couponCode=value;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
        alignment: Alignment.center,child: Text("${Strings.messageDiscountCoupon.tr(context)} $couponDiscount",
      style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
        alignment: Alignment.center,child: Text("${Strings.messageMinimumCoupon.tr(context)} ${value?.minAmount}",
      style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.red.shade400,),);
  }}else{

    couponDiscount=0.0;
    isShippingDiscount=true;
    couponCode=value;
    if((value?.type.toLowerCase()??'')=='percentage'){

      shippingPrice=15-(15*(((value?.percentageAmount??1)/100)));


    }else{
      shippingPrice=15-(value?.fixedAmount??0);

    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
        alignment: Alignment.center,child: Text(Strings.messageShippingCoupon.tr(context),
      style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
  }


print("couponDiscount=$couponDiscount  # ${totalPrice*(((value?.percentageAmount??1)/100))}");
print(couponCode?.toJson());

  emit(CalculateCoupon());
}
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
  void payment(context) async {
    emit(CouponLoading());
    final result = await PostOrderDataHandler.paymentMethod();


    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponNotValid.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
     // Navigator.pop(context);
      emit(CouponError());
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponAddSuccessfully.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
      //Navigator.pop(context);
      emit(CouponSuccess());
    });
  }
  List<Map<String, dynamic>> itemsValue=[];
  void postOrder({
    String? coupon,
    required List items,
    required String customerNotes,
    required BuildContext context,
  }) async {
    itemsValue=[];
    emit(PostOrderLoading());
    for (var action in items) {
      itemsValue.add({
        'name': action['name'],
        'quantity': action['quantity'],
        'image': action['image'],
        'price': action['price'],
        'itemId': action['itemId'],
        'selectedOptionGroups':action['selectedOptionGroups']
      });
    }
    final result;
   // if(coupon!=null){
      result = await PostOrderDataHandler.postOrder(
        coupon: coupon,
        items: itemsValue,
        customerNotes: customerNotes,
      );
   // }
    // else{
    //   result = await PostOrderDataHandler.postOrder(
    //     items: itemsValue,
    //     customerNotes: customerNotes,
    //   );
    // }

    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.failedExecuteOrder.tr(context),style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(PostOrderError());
    }, (r) {
      pageController=PageController(initialPage: 1);
      HomeCubit.get(context).changeNavigator(1);
      PointCubit.get(context).getPointsAndBalance();
      MyOrdersCubit.get(context).getCustomerOrders();
      couponCode=null;
      shippingPrice=15;
      couponDiscount=0.0;
      isShippingDiscount=false;
      values=[];
      for (var element in itemsValue) {
            ProviderCubit.get(context).cardList.removeWhere((test)=>test['itemId']==element['itemId']);
      }
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

 /* void payment1(){


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
      }};


    const apiKey = 'pk_test_Z9MJdDVC96N12UzYPUgdkLREmQJHCmHdjZzY5EZm';
    final encodedApiKey = base64Encode(utf8.encode(apiKey));

    // Request headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $encodedApiKey',
    };
    DioHelper.postData(url: 'https://api.moyasar.com/v1/payments',data:data,headers: headers).then((value) {
      if(value.statusCode==201){
        print("value.data =${value.data}");

    }else{
      print(value.data);}
    }
      );
  }*/
}
