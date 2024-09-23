import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../home/screens/home.dart';

Widget orderPointsGift(order,orderIndex,context)=>Expanded(
  child: Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
      if(language=='English Language')
        Text('You earned ${order!.data![orderIndex].totalPrice??0*10} points for this order',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: borderColor.shade700),),
      if(language!='English Language')
        Row(
          children: [
            Text('لقد حصلت على ',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: isDark??false?Colors.white:borderColor.shade700),),
            Text(' ${(order!.data![orderIndex].totalPrice!+order.data![orderIndex].shippingPrice!)*10} ',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: borderColor.shade700),),
            Text('من هذا الطلب',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: isDark??false?Colors.white:borderColor.shade700),),
          ],
        ),
      InkWell(onTap: (){
        pageController=PageController(initialPage: 1);
        navigate(context, const Home());},
          child: Text(language=='English Language'?'View rewards':'شوف هديتك',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: isDark??false?Colors.white:mainColor.shade700),))
    ],),
);