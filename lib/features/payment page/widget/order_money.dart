import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';
import '../controller/order_cubit.dart';

Widget orderMoney(text,price,oldPrice,check,context,{Color ?colorPrice})=>Padding(
  padding: const EdgeInsets.only(left: 8.0,right: 8),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Text('$text',style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
    Row(children: [
      if(check)
        Text('$oldPrice',style: TextStyle(fontSize: 16 ,decoration: TextDecoration.lineThrough,color: isDark??false?Colors.white:borderColor),),
      if(OrderCubit.get(context).couponCode!=null)
        const SizedBox(width: 10,),
      Text('$price',style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: colorPrice),),
      const SizedBox(width: 3,),
      Text(Strings.sr.tr(context),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: colorPrice),)
    ],)
  ],),
);