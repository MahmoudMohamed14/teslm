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
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/coupon_model.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/screens/home.dart';
import '../../orders/controller/my_orders_cubit.dart';
import '../../point/controller/point_cubit.dart';
import '../../profile/navigator/my_coupons/Models/get_coupons_model.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../screen/pay_screen.dart';
import '../screen/webViewScreen.dart';
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
  String ?orderId;
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
    String?name,
    String?cardNumber,
    String?cvv,
    String?expiryMonth,
    String?expiryYear,
    int?total,
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
        fromBack=false;
        emit(PostOrderError());
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.failedExecuteOrder.tr(context),style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));

      emit(PostOrderError());
    }, (r) {
      print(r);
      if(r['status']){
        orderId=r['id'];
        paymentUrl=null;
        paymentMessageError=null;
        fromBack=true;
        actionPayment(context,cvv: cvv,expiryYear: expiryYear,expiryMonth: expiryMonth,cardNumber: cardNumber,name: name,total: total).then((onValue){
          // createPayment(moyasarId: moyasarId, moyasarPaymentUrl: moyasarPaymentUrl, orderId: orderId, context: context)
        });
        emit(PostOrderSuccess());
      }



    });
  }
  void successPayment(BuildContext context) {
    pageController=PageController(initialPage: 1);
    HomeCubit.get(context).changeNavigator(1);
    PointCubit.get(context).getPointsAndBalance();
    MyOrdersCubit.get(context).getCustomerOrders();
    couponCode=null;
    paymentUrl=null;
    paymentMessageError=null;

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
    fromBack=false;
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
}) async
  {


    final data = {
      "amount":total,
      "currency": "SAR",
      "description": "Payment for order $orderId",
      "callback_url": "https://example.com/thankyou",
      "source": {
        "type": "creditcard",
        "name": name,
        "number": cardNumber,//"4201320111111010",
        "cvc": cvv,
        "month": expiryMonth,
        "year": expiryYear
      }};



    final encodedApiKey = base64Encode(utf8.encode(ApiEndPoint.moyasarPaymentKey));

    // Request headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $encodedApiKey',
    };
    try{
     // emit(ActionPaymentLoading());
      if (kDebugMode) {
        print("payment value =$data");
      }
     final response =await DioHelper.postData(url: ApiEndPoint.moyasarPaymentUrl,data:data,headers: headers);
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
       if( response.data['source']['transaction_url']!=null){
         id=response.data['id'];
        createPayment(moyasarId: response.data['id'], moyasarPaymentUrl:response.data['source']['transaction_url'], orderId: orderId??'', context: context);
        /* //todo test
         paymentUrl=response.data['source']['transaction_url'];
         navigate(context, const WebViewScreen());
         //todo test*/
         fromBack=true;

       //  emit(ActionPaymentSuccess());

       }else{
         showDialogHelper(context, contentWidget:ErrorDialogPayment(message: response.data['source']['message'].toString().tr(context)??'',) , backgroundColor: ThemeModel.of(context).primary);
         emit(ActionPaymentError());

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
        if(e.response?.data['errors']['source.number']!=null) {
          showDialogHelper(context, contentWidget:ErrorDialogPayment(message: e.response?.data['errors']['source.number'].first.toString().tr(context)??'',) , backgroundColor: ThemeModel.of(context).primary);
        }else if(e.response?.data['errors']['name']!=null){
          showDialogHelper(context, contentWidget:ErrorDialogPayment(message: e.response?.data['errors']['name'].first.toString().tr(context)??'',) , backgroundColor: ThemeModel.of(context).primary);
        }
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
    final url = '${ApiEndPoint.moyasarPaymentUrl}/$id';
    if (kDebugMode) {
      print(url);
    }

    // API key encoded in Base64 for authorization

    final encodedApiKey = base64Encode(utf8.encode(ApiEndPoint.moyasarPaymentKey));

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
          successPayment(context);
          emit(GetStatusPaymentSuccess());



        }else{
          fromBack=false;
          showDialogHelper(context, contentWidget:ErrorDialogPayment(message: (response.data['source']['message']??'failed').toString().tr(context),) , backgroundColor: ThemeModel.of(context).primary);

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
  String? paymentUrl;
  String? paymentMessageError;
  void emitPaymentMessageError (){
  emit(PaymentMessageError());
}
  void functionPostOrder(BuildContext context,{ String?name,
    String?cardNumber,
    String?cvv,
    String?expiryMonth,
    String?expiryYear,
    int?total,}){
    postOrder(items: values,coupon:couponCode?.id,customerNotes: customerNotes,context: context
      , scheduledDate:selectedDate != null && selectedTime != null? DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!.hour, selectedTime!.minute):null,
      isScheduled:selectedDate != null && selectedTime != null? true:false,
        cvv: cvv,expiryYear: expiryYear,expiryMonth: expiryMonth,cardNumber: cardNumber,name: name,total: total

    );
  }
  Future<void> createPayment({
    required String moyasarId,
    required String moyasarPaymentUrl,
    required String orderId,
    required BuildContext context,
  }) async {
   // emit(CreatePaymentLoading());
    final result = await PostOrderDataHandler.createPayment(moyasarId: moyasarId, moyasarPaymentUrl: moyasarPaymentUrl, orderId: orderId);




    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(l.errorModel.statusMessage,
          style:const TextStyle(color: Colors.white),)),
      ));
     // Navigator.pop(context);
      fromBack=false;
      emit(CreatePaymentError());
    }, (r) {
      print("create payment ${r}");
      paymentUrl=moyasarPaymentUrl;
      navigate(context, const WebViewScreen());
     //todo _launchUrl(moyasarPaymentUrl);


      emit(CreatePaymentSuccess());
    });
  }

}
