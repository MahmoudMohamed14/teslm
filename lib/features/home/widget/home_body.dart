import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/home/widget/point_and_wallet_card.dart';
import 'package:delivery/features/home/widget/provider_page_navigator.dart';
import 'package:delivery/features/home/widget/providers_card.dart';
import 'package:delivery/features/home/widget/slider_offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/translate/strings.dart';
import '../../point/controller/point_cubit.dart';
import '../../provider page/controller/provider_cubit.dart';
import '../../provider page/screen/Provider page.dart';
import '../controller/home_cubit.dart';
import 'category_card.dart';

Widget homeBody(scrollController,controller,context)=>BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var providers=HomeCubit.get(context).providerData;
    return RefreshIndicator(
  onRefresh: ()async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      HomeCubit.get(context).providerData=null;
      HomeCubit.get(context).getProviderData();
      HomeCubit.get(context).offers();
    });
  },
  child: ListView(
    physics: const BouncingScrollPhysics(),
    controller: scrollController,
    children: [
      if(HomeCubit.get(context).offersData != null) slider(false,controller,context),
      const SizedBox(height:15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          pointsAndWalletCard(context,Strings.points.tr(context),customerId!=null&&PointCubit.get(context).balanceAndPointsData!=null?PointCubit.get(context).balanceAndPointsData!.points:0,ImagesApp.pointsHomeImage),
          pointsAndWalletCard(context,Strings.wallet.tr(context),customerId!=null&&PointCubit.get(context).balanceAndPointsData!=null?PointCubit.get(context).balanceAndPointsData!.balance:0.0,ImagesApp.walletHomeImage)
      ],),
      const SizedBox(height: 15,),
      if(HomeCubit.get(context).categoryData != null)
      GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisSpacing: 0.2,
        mainAxisSpacing: 0.2,
        crossAxisCount: 4,children: List.generate(HomeCubit.get(context).categoryData!.length,
            (index)=> category( HomeCubit.get(context).providerData!.categories?[index],index,context))),
      ListView.builder(
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        itemCount: providers!.categories!.length,
        itemBuilder:(context,categoryIndex)=> Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(providers.categories![categoryIndex].providers!.isNotEmpty)
            Padding(
              padding:  const EdgeInsets.only(left: 10.0,right: 10),
              child: Text(language=='en'? '${providers.categories?[categoryIndex].name?.en}':'${providers.categories?[categoryIndex].name?.ar}',
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
              ),),
            ),
            if(providers.categories![categoryIndex].providers!.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(providers.categories![categoryIndex].providers!.length, (index) => Container(
                  margin: const EdgeInsets.all(5),
                  child: bigCardHome(providers.categories![categoryIndex].providers![index],
                          (){
                            ProviderCubit.get(context).expandedHeight=80;
                            ProviderCubit.get(context).opecity=1;
                            ProviderCubit.get(context).getProviderFoodData(providers.categories?[categoryIndex].providers![index].id);
                        values=[];//todo انا عايز لما يخش ميفضلش يمسح الكارت لو هو كان ضايف قبل كدة متتمسحش الا لو خرج من التطبيق
                        price=0;
                            ProviderCubit.get(context).categoryId=providers.categories![categoryIndex].id;
                        if(providers.categories![categoryIndex].name?.en?.toLowerCase()=='restaurants'){
                          values=[];
                          ProviderCubit.get(context).isRestaurant=true;
                        }else{
                          ProviderCubit.get(context).isRestaurant=false;
                          ProviderCubit.get(context).cardList.forEach((action){
                            if(ProviderCubit.get(context).categoryId==action['categoryId']){
                              values.add(action);

                            }
                          });

                        }
                        print(" name???${providers.categories![categoryIndex].name?.en} ");
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ProviderPage(providerDescription:language=='en'? '${providers.categories![categoryIndex].providers![index].description?.en}':'${providers.categories![categoryIndex].providers![index].description?.ar}' ,
                              providerName: language=='en'?'${providers.categories![categoryIndex].providers![index].providerName?.en}':'${providers.categories![categoryIndex].providers![index].providerName?.ar}',providerCover: '${providers.categories![categoryIndex].providers![index].providerCover}',providerImage: '${providers.categories![categoryIndex].providers![index].providerImage}',),
                            type: PageTransitionType.downToUp,
                          ),
                        );},context),
                )),),
            ),
          ],
        ),
      ),
    ],
  ),
);
  },
);