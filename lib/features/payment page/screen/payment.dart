import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:delivery/features/payment%20page/widget/copoun_bottom_sheet.dart';
import 'package:delivery/features/profile/navigator/my_coupons/controller/coupons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../function/check_copoun.dart';
import '../widget/location_card.dart';
import '../widget/order_brief.dart';
import '../widget/payment_methods card.dart';

class Payment extends StatefulWidget {
  const Payment({super.key,required this.customerNotes});

  final String customerNotes;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).couponCode=null;
    OrderCubit.get(context).couponDiscount=0.0;
    OrderCubit.get(context).shippingPrice=15;
    OrderCubit.get(context).isShippingDiscount=false;
  }
  // Method to pick a date
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }
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
                  _buildScheduledDelivery(context),
                  const SizedBox(height: 10,),
                  Text(Strings.orderSummary.tr(context),style:const TextStyle(fontSize: 19,fontWeight: FontWeight.w700,),),
                  Text(Strings.confirmVat.tr(context),style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  orderBrief(context),
                  const SizedBox(height: 5,),
                ],),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10,right: 15,left: 15),
              child: Column(
                children: [
                  BottomWidget(Strings.addCoupon.tr(context),  (){
                    if(CouponsCubit.get(context).couponsData?.data?.isNotEmpty??false){
                      showModalBottomSheet(
                        isScrollControlled: true,
                        builder: (context) => CouponsBottomSheet(couponsController: _couponController,), context: context,
                      );
                    }else{
                      enterCoupon(context,_couponController);
                    }

                    //enterCoupon(context,_couponController,false);
                    },radius: 20,color: ThemeModel.dark().myAccountBackgroundDarkColor,),
                  const SizedBox(height: 10,),

                  state is PostOrderLoading?
                  SpinKitWave(
                    color:isDark??false? Colors.white:borderColor,
                    size: 30.0,
                  ) : BottomWidget(Strings.confirmOrder.tr(context), (){
                    print(values);
                      OrderCubit.get(context).postOrder(items: values,
                          coupon: OrderCubit
                              .get(context)
                              .couponCode
                              ?.id,
                          customerNotes: widget.customerNotes,
                          scheduledDate:selectedDate != null && selectedTime != null? DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!.hour, selectedTime!.minute):null,
                          isScheduled:selectedDate != null && selectedTime != null? true:false,
                          context: context);
                    },radius: 20,),
                  const SizedBox(height: 10,),
                ],
              ),
            )
          ],
        )
    );
  },
);
  }
  // Widget for selecting scheduled delivery
  Widget _buildScheduledDelivery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.scheduledOrder.tr(context),
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15),
          child: BottomWidget(selectedDate != null && selectedTime != null
              ? "${DateFormat('yyyy-MM-dd').format(selectedDate!)} at ${selectedTime!.format(context)}"
          : Strings.scheduledOrderDate.tr(context), ()=>_selectDateTime(context),radius: 20,),
        ),
      ],
    );
  }
}
final TextEditingController _couponController = TextEditingController();


