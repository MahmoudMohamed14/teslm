import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/applocal.dart';
import 'package:delivery/features/home/widget/point_and_wallet_card.dart';
import 'package:delivery/features/home/widget/provider_page_navigator.dart';
import 'package:delivery/features/home/widget/providers_card.dart';
import 'package:delivery/features/home/widget/slider_offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import '../../../common/constant values.dart';
import '../../../common/translate/strings.dart';
import '../../provider page/screen/Provider page.dart';
import 'category_card.dart';

Widget homeBody(scrollController,controller,context)=>BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var providers=DeliveryCubit.get(context).providerData;
    return RefreshIndicator(
  onRefresh: ()async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      DeliveryCubit.get(context).providerData=null;
      DeliveryCubit.get(context).getProviderData();
      DeliveryCubit.get(context).offers();
    });
  },
  child: ListView(
    physics: const BouncingScrollPhysics(),
    controller: scrollController,
    children: [
      slider(false,controller,context),
      SizedBox(height:15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          pointsAndWalletCard(Strings.points.tr(context),customerId!=null&&DeliveryCubit.get(context).balanceAndPointsData!=null?DeliveryCubit.get(context).balanceAndPointsData!.points:0,ImagesApp.pointsHomeImage),
          pointsAndWalletCard(Strings.wallet.tr(context),customerId!=null&&DeliveryCubit.get(context).balanceAndPointsData!=null?DeliveryCubit.get(context).balanceAndPointsData!.points:0.0,ImagesApp.walletHomeImage)
      ],),
      const SizedBox(height: 15,),
      GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 0.2,
        mainAxisSpacing: 0.2,
        crossAxisCount: 4,children: List.generate(DeliveryCubit.get(context).categoryData!.length,
            (index)=> category( DeliveryCubit.get(context).categoryData![index],index,context))),
      Padding(
        padding:  const EdgeInsets.only(left: 10.0,right: 10),
        child: Text(Strings.selections.tr(context),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
        ),),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(providers!.data!.length, (index) => Container(
            margin: const EdgeInsets.all(5),
            child: bigCardHome(providers.data![index],
                    (){
                  DeliveryCubit.get(context).expandedHeight = 345.0;DeliveryCubit.get(context).imageHeight = 200.0;
                  DeliveryCubit.get(context).containerHeight=180.0;DeliveryCubit.get(context).currentIndex=0;DeliveryCubit.get(context).opecity=1;
                  DeliveryCubit.get(context).containerPadding=100;DeliveryCubit.get(context).rowItems=150;
                  DeliveryCubit.get(context).getProviderFoodData(providers.data![index].id);
                  values=[];price=0;
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ProviderPage(providerDescription:language=='en'? '${providers.data![index].description!.en}':'${providers.data![index].description!.ar}' ,
                        providerName: language=='en'?'${providers.data![index].providerName!.en}':'${providers.data![index].providerName!.ar}',providerCover: '${providers.data![index].providerCover}',providerImage: '${providers.data![index].providerImage}',),
                      type: PageTransitionType.downToUp,
                    ),
                  );},context),
          )),),
      ),
    ],
  ),
);
  },
);