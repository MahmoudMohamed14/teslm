import 'package:flutter/material.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant/constant values.dart';

Widget locationDetails(context)=>Container(
  padding:const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(language=='English Language'?'Delivering to':'توصيل إلى',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),),
      Row(children: [Icon(Icons.home,size: 40,color: mainColor.shade500,),
        const SizedBox(width: 5,),
        Text(language=='English Language'?'Apartment':'البيت',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
      ],),
      Text(DeliveryCubit.get(context).currentLocationName,textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
    ],),
);