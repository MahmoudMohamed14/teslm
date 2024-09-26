import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../Dio/Dio.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/coupon model.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/screens/home.dart';
import '../../point/controller/point_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);

  Coupon ?couponData;
  void postCoupon({
    required String coupon,
    required int subtotal,
    required int shippingPrice,
    context
  }){
    emit(CouponLoading());
    DioHelper.postData(url: 'coupons/validate', data: {
      'code' : coupon,
      'subtotal':subtotal,
      'shippingPrice':shippingPrice
    }).then((value) {
      couponData=Coupon.fromJson(value.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Coupon add successfully":'تم اضافه الكوبون بنجاح',
          style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      Navigator.pop(context);
      emit(CouponSuccess());
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Coupon is not valid":'الكوبون ليس صحيح',
          style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      Navigator.pop(context);
      emit(CouponError());
    });
  }
  void postOrder({
    String? coupon,
    required List items,
    required String customerId,
    required String deliveryPartnerId,
    required String customerNotes,
    context
  }){
    emit(PostOrderLoading());
    var postdata={
      "items": items,
      "deliveryPartnerId": "07cfd32e-7a27-468a-96ea-f527c9cbc496",
      "customerId": customerId,
      "customerNotes": customerNotes
    };
    DioHelper.postData(url: 'orders', data:postdata).then((value) {
      pageController=PageController(initialPage: 2);
      HomeCubit.get(context).changeNavigator(2);
      PointCubit.get(context).getPointsAndBalance();
      DeliveryCubit.get(context).getCustomerOrders();
      couponData=null;
      navigateAndFinish(context,const Home());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(language=='English Language'?'Order has been done successfully':"تم تنفيذ الطلب بنجتح",
        style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      emit(PostOrderSuccess());
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Failed to execute the order":'فشل تنفيذ الاوردر',style:const TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(PostOrderError());
    });
  }
}
