import 'dart:async';
import 'dart:convert';

import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Dio/Dio.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/coupon_model.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/screens/home.dart';
import '../../orders/controller/my_orders_cubit.dart';
import '../../point/controller/point_cubit.dart';
import '../../profile/navigator/my_coupons/Models/get_coupons_model.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../widget/error_dialog.dart';
import 'order_data_handler.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);

  double shippingPrice=15;
  double couponDiscount=0.0;
  bool isShippingDiscount=false;
  String customerNotes='';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  CouponData?couponCode;
  void init(){
   couponCode=null;
  couponDiscount=0.0;
    shippingPrice=15;
   isShippingDiscount=false;
    fromBack=false;
  }
void getCoupon(BuildContext context, {CouponData ?value}) async {
  couponDiscount=0.0;
  isShippingDiscount=false;
  shippingPrice=15;
  double totalPrice=ProviderCubit.get(context).getPrice();
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


if (kDebugMode) {
  print("couponDiscount=$couponDiscount  # ${totalPrice*(((value?.percentageAmount??1)/100))}");
  print(couponCode?.toJson());
}


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
  /*void payment(context) async {
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
  }*/
  List<Map<String, dynamic>> itemsValue=[];
  void postOrder({
    String? coupon,
    required List items,
    required String customerNotes,
    required BuildContext context,
    bool? isScheduled, // Pass the scheduling status
    DateTime? scheduledDate,
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
        scheduledDate: scheduledDate,
        isScheduled: isScheduled
      );
   // }
    // else{
    //   result = await PostOrderDataHandler.postOrder(
    //     items: itemsValue,
    //     customerNotes: customerNotes,
    //   );
    // }

    result.fold((l) {
      if (kDebugMode) {
        print("error is ${l.errorModel.statusMessage}");
      }
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
      fromBack=false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(Strings.orderDoneSuccessfully.tr(context),
        style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      emit(PostOrderSuccess());
    });
  }
  List<bool> isCheckedList =[ true,false,false];
  bool choosePadding =true;
  bool fromBack=false;
  void changePaymentMethod(index){
    if(index==1){isCheckedList=[false,true,false];emit(Reload());}
    else if(index==2){isCheckedList=[false,false,true];emit(Reload());}
    else {isCheckedList=[true,false,false];emit(Reload());}
    choosePadding =false;
    Timer(const Duration(milliseconds: 350), () {
      choosePadding = true;
      emit(Reload());
    });
  }
  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }
String?id;
  Future<void> actionPayment(BuildContext context,{
    String?name,
    String?cardNumber,
    String?cvv,
    String?expiryMonth,
    String?expiryYear,
    int?total,
}) async {


    final data = {
      "amount":total,
      "currency": "SAR",
      "description": "Payment for order #123456789",
      "callback_url": "https://example.com/thankyou",
      "source": {
        "type": "creditcard",
        "name": name,
        "number": cardNumber,//"4201320111111010",
        "cvc": cvv,
        "month": expiryMonth,
        "year": expiryYear
      }};


    const apiKey = 'sk_test_4hPQUZG3KYCdoRCRkQvoSYAtDyDdEYcRRk27a5mo';
    final encodedApiKey = base64Encode(utf8.encode(apiKey));

    // Request headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $encodedApiKey',
    };
    try{
      emit(ActionPaymentLoading());
      if (kDebugMode) {
        print("payment value =$data");
      }
     final response =await DioHelper.postData(url: 'https://api.moyasar.com/v1/payments',data:data,headers: headers);
      // .then((value) {
    //
    //
    //   if(value.statusCode==201){
    //     fromBack=true;
    //     _launchUrl(value.data['source']['transaction_url']);
    //     id=value.data['id'];
    //
    //
    //     print("value.data =${value.data}");
    //
    // }else{
    //   print(value.data);}
    // }
    //   );
      if (response.statusCode == 200||response.statusCode==201) {
        fromBack=true;
        _launchUrl(response.data['source']['transaction_url']);
        id=response.data['id'];
        emit(ActionPaymentSuccess());



        if (kDebugMode) {
          print('Payout Data: ${response.data}');
        }
        // Handle payout data (e.g., update UI or save data)
      } else {
        if (kDebugMode) {
          print('Failed to fetch payout: ${response.statusCode}');
          print('Response: ${response.data}');
        }



        emit(ActionPaymentError());
      }
    }on DioException catch (e) {
      if (kDebugMode) {
        print('Dio Error: ${e.message}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('Error Response Data: ${e.response?.data}');
        }
        showDialogHelper(context, contentWidget:ErrorDialogPayment(message: e.response?.data['errors']['source.number'].first.toString().tr(context)??'',) , backgroundColor: ThemeModel.of(context).primary);
        emit(ActionPaymentError());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected Error: $e');
      }
      emit(ActionPaymentError());
    }
  }

  Future<void> getPayoutStatusById(context) async {
    emit(GetStatusPaymentLoading());
    final dio = Dio();

    // URL with the payout ID in the path
    final url = 'https://api.moyasar.com/v1/payments/$id';
    if (kDebugMode) {
      print(url);
    }

    // API key encoded in Base64 for authorization
    const apiKey = 'sk_test_4hPQUZG3KYCdoRCRkQvoSYAtDyDdEYcRRk27a5mo';
    final encodedApiKey = base64Encode(utf8.encode(apiKey));

    // Request headers
    final headers = {
      'Authorization': 'Basic $encodedApiKey',
    };

    try {
      // Send the GET request
      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200||response.statusCode==201) {
        if(response.data['status']=='paid'){
          emit(GetStatusPaymentSuccess());
          postOrder(items: values,coupon:couponCode?.id,customerNotes: customerNotes,context: context
              , scheduledDate:selectedDate != null && selectedTime != null? DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!.hour, selectedTime!.minute):null,
            isScheduled:selectedDate != null && selectedTime != null? true:false,
          );


        }else{
          fromBack=false;
          showDialogHelper(context, contentWidget:ErrorDialogPayment(message: response.data['source']['message'].toString().tr(context)??'',) , backgroundColor: ThemeModel.of(context).primary);

          emit(GetStatusPaymentError());

        }
        if (kDebugMode) {
          print('Payout Data: ${response.data}');
        }
        // Handle payout data (e.g., update UI or save data)
      } else {


        if (kDebugMode) {
          print('Failed to fetch payout: ${response.statusCode}');
          print('Response: ${response.data}');
        }
        fromBack=false;
        emit(GetStatusPaymentError());

      }
    } on DioException catch (e) {
      fromBack=false;
      if (kDebugMode) {
        print('Dio Error: ${e.message}');
      }
      emit(GetStatusPaymentError());
      if (e.response != null) {
        fromBack=true;
        if (kDebugMode) {
          print('Error Response Data: ${e.response?.data}');
        }
        emit(GetStatusPaymentError());
      }
    } catch (e) {
      fromBack=false;
      if (kDebugMode) {
        print('Unexpected Error: $e');
      }
      emit(GetStatusPaymentError());
    }
  }
}
