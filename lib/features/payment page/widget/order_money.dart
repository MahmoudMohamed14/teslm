import 'package:delivery/common/translate/applocal.dart';
import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant values.dart';
import '../../../common/translate/strings.dart';

Widget orderMoney(text,price,oldPrice,check,context)=>Padding(
  padding: const EdgeInsets.only(left: 8.0,right: 8),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Text('$text',style:const TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
    Row(children: [
      if(check)
        Text('$oldPrice',style: TextStyle(fontSize: 16 ,decoration: TextDecoration.lineThrough,color: isDark??false?Colors.white:borderColor),),
      if(DeliveryCubit.get(context).couponData!=null)
        const SizedBox(width: 5,),
      Text('$price',style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
      const SizedBox(width: 3,),
      Text(Strings.sar.tr(context),style:const TextStyle(fontWeight: FontWeight.w200,fontSize: 15),)
    ],)
  ],),
);