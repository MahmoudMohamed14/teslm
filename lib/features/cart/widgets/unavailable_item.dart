import 'package:delivery/common/translate/applocal.dart';
import 'package:flutter/material.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant values.dart';
import '../../../common/translate/strings.dart';
import 'bottom_sheet_items.dart';

Widget unavailableItem(context){
  List<String> listUnavailableItems =[ Strings.removeItemOrder.tr(context),Strings.cancelOrder.tr(context)];
  return InkWell(
  onTap: (){showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return   const CustomBottomSheet();});},
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Icon(Icons.arrow_back_ios),
      const Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(Strings.itemIsUnavailable.tr(context) ,style: TextStyle(fontFamily: 'fontTop',color: isDark??false? floatActionColor:borderColor.shade700,fontWeight: FontWeight.w500,fontSize: 16),),
          Text(choose? listUnavailableItems[1]:listUnavailableItems[0],style: const TextStyle(fontFamily: 'fontTop',fontWeight: FontWeight.w500,fontSize: 18),),
        ],),
      const SizedBox(width: 5,),
      const Icon(Icons.shopping_bag_outlined,size: 28,),

    ],
  ),
);}
