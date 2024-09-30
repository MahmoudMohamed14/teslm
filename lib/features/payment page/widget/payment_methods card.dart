import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';
import '../../point/controller/point_cubit.dart';
Widget paymentMethodCard(context) {
  List<IconData> listIcons=[Icons.credit_card,Icons.apple_outlined,Icons.account_balance_wallet_rounded];
  List<String> listPaymentMethod =[ Strings.payVisa.tr(context),Strings.payApple.tr(context),Strings.payTeslmCash.tr(context)];
  return BlocConsumer<OrderCubit, OrderState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
      color: ThemeModel.of(context).cardsColor,
      borderRadius: BorderRadius.circular(10)),
  child: ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 3,
    itemBuilder: (context,index)=> ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(listIcons[index]),
              const SizedBox(width: 8,),
              Column(children: [
                Text(listPaymentMethod[index],style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                if(index==2)
                  Row(
                    children: [
                      Text(Strings.sr.tr(context),style:const TextStyle(fontSize: 16),),
                      const SizedBox(width: 5,),
                      Text(PointCubit.get(context).balanceAndPointsData!=null?'${PointCubit.get(context).balanceAndPointsData!.balance}':'0.0',maxLines: 1,overflow: TextOverflow.ellipsis,
                        style:const TextStyle(fontSize: 16),),
                    ],
                  )
              ],)
            ],
          ),
          AnimatedContainer(
            duration:const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: !DeliveryCubit.get(context).choosePadding&&DeliveryCubit.get(context).isCheckedList[index]==true?ThemeModel.mainColor:null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1.2,color: isDark??false ?DeliveryCubit.get(context).isCheckedList[index]==true? ThemeModel.mainColor:floatActionColor:DeliveryCubit.get(context).isCheckedList[index]==true?ThemeModel.mainColor:borderColor)),
              child: CircleAvatar(
                radius:5,
                backgroundColor: DeliveryCubit.get(context).isCheckedList[index]==true?ThemeModel.mainColor: isDark??false ?Colors.black12:floatActionColor,
              ),
            ),
          ),
        ],
      ),
      onTap:(){ DeliveryCubit.get(context).changePaymentMethod(index);},
    ),
    separatorBuilder:(context,index)=> seperate(),
  ),
);
  },
);
}
