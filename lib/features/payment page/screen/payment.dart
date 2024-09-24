import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../common/colors/theme_model.dart';
import '../function/check_copoun.dart';
import '../widget/location_card.dart';
import '../widget/order_brief.dart';
import '../widget/payment_methods card.dart';

class Payment extends StatelessWidget {
  const Payment({super.key,required this.customerNotes});

  final String customerNotes;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.reviewOrder.tr(context)),leading: InkWell(onTap:(){if(loginFromCart){Navigator.pop(context);Navigator.pop(context);Navigator.pop(context);loginFromCart=false;}else{Navigator.pop(context);}},
          child: const Icon(Icons.arrow_back_outlined)),),
        body:Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: ListView(children: [
                  Text(Strings.orderDetails.tr(context),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: isDark??false? floatActionColor:brownColor),),
                  const SizedBox(height: 8,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color:
                    borderColor)),
                    padding:const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Icon(Icons.more_time_rounded,color: isDark??false ?floatActionColor:brownColor,),
                      Text(Strings.expectedTimer.tr(context),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color:isDark??false? floatActionColor: brownColor.shade300),),
                      Text(Strings.arrivalTime.tr(context),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,color: isDark??false? floatActionColor:brownColor),),
                    ],),
                  ),const SizedBox(height: 15,),
                  locationCard(context),
                  const SizedBox(height: 10,),
                  Text(Strings.paymentDetails.tr(context),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: isDark??false? floatActionColor:brownColor),),
                  const SizedBox(height: 10,),
                  paymentMethodCard(context),
                  const SizedBox(height: 10,),
                  Text(Strings.orderSummary.tr(context),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: isDark??false? floatActionColor:brownColor),),
                  Text(Strings.confirmVat.tr(context),style: TextStyle(color: isDark??false? floatActionColor:brownColor.shade400),),
                  const SizedBox(height: 10,),
                  orderBrief(context)
                ],),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: DeliveryCubit.get(context).couponData!=null? null:(){enterCoupon(context,_couponController);},
                  child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: ThemeModel.mainColor,borderRadius: BorderRadius.circular(8)),
                  width: language=='en'?160:140,
                    child: Row(children: [
                      Text(Strings.addCoupon.tr(context),
                        style:const TextStyle(fontSize: 19,fontWeight: FontWeight.w500,color: Colors.white,),),
                      const Icon(Icons.control_point,size: 27,color: Colors.white,),
                    ],),
                  ),
                ),
              ],),
            ),
            state is PostOrderLoading?
            SpinKitWave(
              color:isDark??false? Colors.white:borderColor,
              size: 25.0,
            )
            :cartPaymentBottom(Strings.confirmOrder.tr(context), (){
              DeliveryCubit.get(context).postOrder(items: values, customerId: '$customerId',coupon: _couponController.text ,deliveryPartnerId: 'trhygfdgfdh', customerNotes: customerNotes,context: context);
            }, false,context),
          ],
        )
    );
  },
);
  }
}
final TextEditingController _couponController = TextEditingController();


