import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/orders/controller/my_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../order details/screen/orderDetails.dart';
import '../widget/loading_orders.dart';
import '../widget/order_card.dart';


class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: ThemeModel.of(context).greenAppBar, // Set the status bar color
    ));
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: appBarWithIcons(Strings.myOrders.tr(context),ImagesApp.myOrdersAppBarImage,false,context),
      ),
        body: MyOrdersCubit.get(context).customerOrders != null && state is! GetOrdersLoading ? SafeArea(
            child: MyOrdersCubit.get(context).customerOrders!.data!.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RefreshIndicator(
                    onRefresh: ()async {
                      await Future.delayed(const Duration(milliseconds: 500), () {
                        MyOrdersCubit.get(context).customerOrders=null;
                        MyOrdersCubit.get(context).getCustomerOrders();
                      });
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                        itemCount: MyOrdersCubit.get(context).customerOrders?.data?.length,
                        itemBuilder: (context, index) =>
                            InkWell(
                                onTap: () {
                                  navigate(context, OrderDetails(orderIndex: index,));
                                },
                                child: orderCard(MyOrdersCubit.get(context).customerOrders!.data![index],context))),
                  )
                ],),
            ) : Center(
              child: Stack(
                children: [
                  const Image(image: AssetImage(ImagesApp.bagImage),
                    height: 250,
                    width: 200,),
                  Positioned(
                    left: language == 'en' ? 40 : 60,
                    bottom: 30,
                    child: Text(Strings.noOrdersFounded.tr(context), style: const TextStyle(
                        fontWeight: FontWeight.w700),),)
                ],),
            )) :ordersLoading(context)
    );});
  }
}
