import 'package:delivery/common/translate/applocal.dart';
import 'package:flutter/cupertino.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';
import '../../../common/translate/strings.dart';

Widget storeCard(context,providerImage,providerName,providerDescription)=>ListView(
  physics: const NeverScrollableScrollPhysics(),
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        image('$providerImage', 40.0, 40.0, 40.0,BoxFit.fill),
        Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: SizedBox(
              width: MediaQuery.sizeOf(context).width/1.5,
              child: Text('$providerName',maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
        ),
      ],),
    AnimatedOpacity(
        duration: const Duration(milliseconds: 300), // Duration of the animation
        opacity: DeliveryCubit.get(context).opecity,
        child: Text("$providerDescription",style: TextStyle(color: isDark??false? floatActionColor:borderColor.shade500,fontWeight: FontWeight.w500,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,)),
    Container(height: 40,), // Add the Spacer widget
    AnimatedOpacity(
        duration: const Duration(milliseconds: 500), // Duration of the animation
        opacity: DeliveryCubit.get(context).opecity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [Text(Strings.deliveryTime.tr(context),style: TextStyle(fontSize: 13,color: isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
              Text(Strings.timeMinutes.tr(context),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),),
            ],),
            Column(children: [Text(Strings.deliveryFee.tr(context),style: TextStyle(fontSize: 13,color: isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
              Text('0 - 15 ${Strings.minimumOrder.tr(context)}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:isDark??false? floatActionColor:brownColor),),
            ],),Column(children: [Text(Strings.minimumOrder.tr(context),style: TextStyle(fontSize: 13,color: isDark??false? floatActionColor:brownColor,fontWeight: FontWeight.bold,),),
              Text('20 ${Strings.sar.tr(context)}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: isDark??false? floatActionColor:brownColor),),
            ],),
          ],
        )
    ),
  ],
);