import 'package:delivery/Cubite/delivery_cubit.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/point/controller/point_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../widget/how_points.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PointCubit, PointState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.points.tr(context),ImagesApp.pointsAppBarImage,false,context),
      ),
      body: SafeArea(child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
            child: Row(children: [
              if(PointCubit.get(context).balanceAndPointsData!=null)
                Text('${PointCubit.get(context).balanceAndPointsData?.points} ',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              if(PointCubit.get(context).balanceAndPointsData==null)
                Skeleton(height: 15.0,width: 50.0),
              Text(Strings.point.tr(context),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color:ThemeModel.of(context).pointBigCardColor,
              child: Container(
                padding:const EdgeInsets.all(10),
                child: Row(children: [
                  CircleAvatar(
                      backgroundColor: ThemeModel.of(context).greenAppBar,
                      radius: 18,
                      child: SvgPicture.asset(
                        ImagesApp.pointTopImage,
                      )),
                  const SizedBox(width: 8,),
                  Expanded(child: Text(Strings.whatDiscount.tr(context),style: const TextStyle(fontWeight: FontWeight.bold,),maxLines: 2,)),
                  const SizedBox(width: 8,),
                  state is RedeemPointsLoading? SpinKitWave(
                    color:isDark??false? Colors.white:borderColor,
                    size: 25.0,
                  ): InkWell(
                    onTap: (){PointCubit.get(context).redeemPointsCustomer(context);},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: ThemeModel.of(context).iconMainColor,borderRadius: BorderRadius.circular(20)),
                      child: Row(children: [
                        Text(Strings.redeemYourPoints.tr(context),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white,),),
                      ],),
                    ),
                  ),
                ],),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Text(Strings.howWork.tr(context),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              color:ThemeModel.of(context).pointBigCardColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    howPoints(Strings.orderCollectPoints.tr(context),ImagesApp.shopCarImage,Strings.payReturned.tr(context),context),
                    howPoints(Strings.discoverShops.tr(context),ImagesApp.shopPointImage,Strings.howManyPointGet.tr(context),context),
                    howPoints(Strings.redeemYourPoints.tr(context),ImagesApp.pointBottomImage,Strings.replacePoints.tr(context),context),
                  ],),
              ),
            ),
          )
        ],
      )),
    );
  },
);
  }
}

