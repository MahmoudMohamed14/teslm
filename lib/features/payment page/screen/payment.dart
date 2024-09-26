import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../function/check_copoun.dart';
import '../widget/location_card.dart';
import '../widget/order_brief.dart';
import '../widget/payment_methods card.dart';

class Payment extends StatelessWidget {
  const Payment({super.key,required this.customerNotes});

  final String customerNotes;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: appBarWithIcons(Strings.reviewOrder.tr(context),ImagesApp.myOrdersAppBarImage,true,context),
      ),
        body:Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: ListView(children: [
                  Text(Strings.orderDetails.tr(context),style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w700,),),
                  const SizedBox(height: 8,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ThemeModel.of(context).cardsColor,
                      borderRadius: BorderRadius.circular(10),),
                    padding:const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            backgroundColor: ThemeModel.of(context).greenAppBar,
                            radius: 18,
                            child: SvgPicture.asset(
                              ImagesApp.clockImage,
                            )),
                      Text(Strings.expectedTimer.tr(context),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.w700,),),
                      Text(Strings.arrivalTime.tr(context),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700,),),
                    ],),
                  ),const SizedBox(height: 15,),
                  locationCard(context),
                  const SizedBox(height: 10,),
                  Text(Strings.paymentDetails.tr(context),style:const TextStyle(fontSize: 19,fontWeight: FontWeight.w700,),),
                  const SizedBox(height: 10,),
                  paymentMethodCard(context),
                  const SizedBox(height: 10,),
                  Text(Strings.orderSummary.tr(context),style:const TextStyle(fontSize: 19,fontWeight: FontWeight.w700,),),
                  Text(Strings.confirmVat.tr(context),style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  orderBrief(context),
                  const SizedBox(height: 5,),
                ],),
              ),
            ),
            bottom(Strings.addCoupon.tr(context),  OrderCubit.get(context).couponData!=null? null:(){enterCoupon(context,_couponController);},radius: 20,color: ThemeModel.dark().myAccountBackgroundDarkColor,),
            const SizedBox(height: 10,),
            state is PostOrderLoading?
            SpinKitWave(
              color:isDark??false? Colors.white:borderColor,
              size: 30.0,
            ) : bottom(Strings.confirmOrder.tr(context), (){
              OrderCubit.get(context).postOrder(items: values, customerId: '$customerId',coupon: _couponController.text ,deliveryPartnerId: 'trhygfdgfdh', customerNotes: customerNotes,context: context);
            },radius: 20,),
            const SizedBox(height: 20,)
          ],
        )
    );
  },
);
  }
}
final TextEditingController _couponController = TextEditingController();


