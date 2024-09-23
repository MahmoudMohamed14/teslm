import 'package:delivery/features/order%20details/widgets/top_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import 'delivery_man_details.dart';
import 'location_data.dart';
import 'order_details.dart';
import 'order_point_gift.dart';
import 'order_status.dart';

class MyDraggableSheet extends StatelessWidget {
  final Widget child;
  final int orderIndex;
  MyDraggableSheet({super.key, required this.child,required this.orderIndex});

  final sheet = GlobalKey();
  final controller = DraggableScrollableController();
  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    int index = 3;
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var order=DeliveryCubit.get(context).customerOrders;
        return LayoutBuilder(builder: (context, constraints) {
          return DraggableScrollableSheet(
            key: sheet,
            initialChildSize: 0.85,
            maxChildSize: 0.85,
            minChildSize: 0.85,
            expand: false,
            snap: false,

            controller: controller,
            builder: (BuildContext context, ScrollController scrollController) {
              return DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        physics:const NeverScrollableScrollPhysics(),
                        slivers: [
                          topButtonIndicator(),
                          orderStatus(index),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    language == 'English Language'
                                        ? 'Mostafa is coming to you'
                                        : 'مصطفى تحرك من المطعم وفى الطريق اليك',
                                    style:const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  seperate(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/1.6,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 5,),
                          deliveryManDetails(),
                          Container(
                            padding:const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                            color: mainColor.shade50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                orderPointsGift(order,orderIndex,context),
                                const Image(image: AssetImage(ImagesApp.giftImage),height: 60,width: 60,),
                              ],),),
                          locationDetails(context),
                          Container(
                            padding:const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(language=='English Language'?'Your order from':'طلبك من',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language=='English Language'?'${order!.data![orderIndex].providerOrders!.providerName!.en}':'${order!.data![orderIndex].providerOrders!.providerName!.ar}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                    image('${order.data![orderIndex].providerOrders!.providerImage}', 40.0, 50.0, 5.0,BoxFit.cover),
                                  ],),
                                Text(language=='English Language'?'${order.data![orderIndex].providerOrders!.description!.en}':'${order.data![orderIndex].providerOrders!.description!.ar}',textDirection:language=='English Language'? TextDirection.ltr:TextDirection.rtl,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: isDark??false?Colors.white:borderColor.shade700),)
                              ],),
                          ),
                          orderDetails(order,orderIndex)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }
}