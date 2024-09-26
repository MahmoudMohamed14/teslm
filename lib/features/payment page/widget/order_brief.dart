import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import '../controller/order_cubit.dart';
import 'order_money.dart';

Widget orderBrief(context)=>Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
      color: ThemeModel.of(context).cardsColor,
      borderRadius: BorderRadius.circular(10)),
  height: 210,
  child: Column(children: [
    orderMoney(Strings.totalOrder.tr(context),OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='ORDER'?'${price-(OrderCubit.get(context).couponData!.discount)!.toInt()}':price:price,
        '$price' ,OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='ORDER':false,context),
    seperate(),
    orderMoney(Strings.deliveryFee.tr(context),OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='SHIPPING'?
    '${shippingPrice-(OrderCubit.get(context).couponData!.discount)!.toInt()}':shippingPrice:shippingPrice,
        '$shippingPrice',  OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='SHIPPING':false,context),
    seperate(),
    if(OrderCubit.get(context).couponData!=null)
      orderMoney(Strings.youSaved.tr(context),OrderCubit.get(context).couponData!.discount,0,false,context),
    Row(
      children: [
        const Image(image: AssetImage(ImagesApp.pointImage),height: 20,width: 20,),
        const SizedBox(width: 7,),
        Text(Strings.getPointsOrder.tr(context),style: TextStyle(fontWeight: FontWeight.w700,color: Colors.green.shade600),),
        Text('${price*10} ${Strings.point.tr(context)} ',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.green.shade600),),
      ],
    ),
    seperate(),
    orderMoney(Strings.total.tr(context),OrderCubit.get(context).couponData!=null?'${totalPrice-(OrderCubit.get(context).couponData!.discount)!.toInt()}':totalPrice,
        OrderCubit.get(context).couponData!=null?'$totalPrice':totalPrice,OrderCubit.get(context).couponData!=null?true:false,context),
  ],),);