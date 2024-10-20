import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
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
  child: Container(
    padding:const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ThemeModel.of(context).cardsColor,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            backgroundColor: ThemeModel.of(context).greenAppBar,
            radius: 18,
            child: SvgPicture.asset(
              ImagesApp.cartShop,
            )),
        const SizedBox(width: 7,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.itemIsUnavailable.tr(context) ,style: TextStyle(color: isDark??false? floatActionColor:borderColor.shade700,fontWeight: FontWeight.w400,fontSize: 16),),
            Text(choose? listUnavailableItems[1]:listUnavailableItems[0],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
          ],),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_outlined,color: ThemeModel.mainColor,),
      ],
    ),
  ),
);
}
