import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
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
    orderMoney(Strings.totalOrder.tr(context),OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='ORDER'?'${ProviderCubit.get(context).getPrice()-(OrderCubit.get(context).couponData!.discount)!.toInt()}':ProviderCubit.get(context).getPrice():ProviderCubit.get(context).getPrice(),
        '${ProviderCubit.get(context).getPrice()}' ,OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='ORDER':false,context),
    seperate(),
    orderMoney(Strings.deliveryFee.tr(context),OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='SHIPPING'?
    '${ OrderCubit.get(context).shippingPrice-(OrderCubit.get(context).couponData!.discount)!.toInt()}':OrderCubit.get(context).shippingPrice:OrderCubit.get(context).shippingPrice,
        '${ OrderCubit.get(context).shippingPrice}',  OrderCubit.get(context).couponData!=null?OrderCubit.get(context).couponData!.appliedOn=='SHIPPING':false,context),
    seperate(),
    if(OrderCubit.get(context).couponData!=null)
      orderMoney(Strings.youSaved.tr(context),OrderCubit.get(context).couponData!.discount,0,false,context),
    Row(
      children: [
        const Image(image: AssetImage(ImagesApp.pointImage),height: 20,width: 20,),
        const SizedBox(width: 7,),
      //  Text(Strings.getPointsOrder.tr(context),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.green.shade600),),
        Flexible(child: Text('${Strings.getPointsOrder.tr(context)}${(ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice-((OrderCubit.get(context).couponDiscount).toInt()))*10} ${Strings.point.tr(context)} ',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.green.shade600),)),
      ],
    ),
    seperate(),
    orderMoney(Strings.total.tr(context),OrderCubit.get(context).couponCode!=null?'${(ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice)-(OrderCubit.get(context).couponDiscount)!.toInt()}':(ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice),
        OrderCubit.get(context).couponCode!=null?'${(ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice)}':(ProviderCubit.get(context).getPrice()+OrderCubit.get(context).shippingPrice),OrderCubit.get(context).couponCode!=null?true:false,context),
  ],),);