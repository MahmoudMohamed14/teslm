import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import '../screen/orderDetails.dart';

Widget deliveryManDetails()=>Padding(
  padding: const EdgeInsets.only(top: 15.0,bottom: 15),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        ImagesApp.deliveryManImage,
        width: 90,
        height: 90,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mostafa',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            Text(language=='English Language'?'Is your delivery hero for today':'هو بطل توصيل طلبك اليوم',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
          ],),
      ),
      Row(
        children: [
          InkWell(
            onTap: (){
              makePhoneCall('+966566310766');
            },
            child: CircleAvatar(
                radius: 20,
                child: Icon(Icons.phone,size: 30,color: ThemeModel.mainColor,)),
          ),
          const SizedBox(width: 15,),
          InkWell(
            onTap: ()async{
              openWhatsAppChat('+966566310766');
            },
            child:const CircleAvatar(
                radius: 20,child: Image(image: AssetImage(ImagesApp.whatsAppImage),width: 40,height: 40,)),
          ),
          const SizedBox(width: 15,),
          CircleAvatar(
              radius: 20,child: Icon(Icons.chat,size: 30,color: ThemeModel.mainColor)),
        ],
      ),
    ],),
);