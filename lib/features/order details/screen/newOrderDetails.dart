import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';


class NewOrderDetails extends StatelessWidget {
  const NewOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.delivery.tr(context),

            ImagesApp.clockImageAppBar, true, context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: .5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 13),
              decoration: BoxDecoration(
                  color: ThemeModel.of(context).pointBigCardColor,
                borderRadius: BorderRadius.circular(18),


              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:ThemeModel.of(context).greenAppBar ,
                    radius: 15,
                    child: Center(child: SvgPicture.asset(ImagesApp.giftSvg)),
                  ),
                  11.0.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        Strings.youEarned70Points.tr(context),
                        style: TextStyleHelper.of(context).medium18.copyWith(color: ThemeModel.of(context).font1),

                      ),
                      AppTextWidget(
                        Strings.forThisOrder.tr(context),
                        style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1),

                      ),
                    ],
                  ).expand,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7,horizontal:10),
                    decoration: BoxDecoration(
                      color: ThemeModel.mainColor,
                      borderRadius: BorderRadius.circular(18),


                    ),
                    child: AppTextWidget(
                      Strings.viewRewards.tr(context),
                      style: TextStyleHelper.of(context).medium14.copyWith(color: Colors.white),

                    ),
                  ),
                ],
              ),
            ),
          ),
          24.h.heightBox,
          AppTextWidget(
            Strings.deliveryLocation.tr(context),
            style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1),

          ),
          10.h.heightBox,
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: .5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 13),
                decoration: BoxDecoration(
                  color: ThemeModel.of(context).pointBigCardColor,
                  borderRadius: BorderRadius.circular(18),


                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor:ThemeModel.of(context).greenAppBar ,
                      radius: 15,
                      child: Center(child: SvgPicture.asset(ImagesApp.locationSvg)),
                    ),
                    11.0.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          Strings.orderLocation.tr(context),
                          style: TextStyleHelper.of(context).regular16.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w600),

                        ),
                        5.h.heightBox,
                        AppTextWidget(
                          Strings.apartment.tr(context),
                          style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1),

                        ),
                       5.h.heightBox,
                        AppTextWidget(
                          'Al-Waleed Ibn Hisham Ibn Muawiyah, 4362, Al-Khalidiyah District, 6964, MCKA6946 Mecca 24232, Saudi Arabia, Mecca, Saudi Arabia',
                          style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,height: 1.3),
                          textAlign: TextAlign.start,

                        ),
                      ],
                    ).expand,

                  ],
                ),
              ),
            ),
            24.h.heightBox,
            AppTextWidget(
              Strings.yourOrderFrom.tr(context),
              style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1),

            ),
            10.h.heightBox,
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: .5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 13),
                decoration: BoxDecoration(
                  color: ThemeModel.of(context).pointBigCardColor,
                  borderRadius: BorderRadius.circular(18),


                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image('https://s3-alpha-sig.figma.com/img/cb59/edd8/c8a22948d62fd86a21170164392d8b48?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=du3khvWHndmvkfEW3vuNlQm7PenUyAhrIP05GSuTN6v2ko8-OeXnCnC47dCRFSA5tNVSlkiMzjAKpZ7SGhP3L8R5m3T-ksq-m62W7z7Yk28VGqcJkUZmIU6KQuvrXIUJPPdznEHKRn7hF8NoqssQL0lQqnYDrxOdyW3WNYrshmAF5apkRaBGcQvq~Q~mTxOeCioc7-MlPjg7AVMsnj-aNv47VINaLSkNbKV1bo6H4QwaJpt4MwbAUAp8gFwnfU1YHOXrsvwebopD0m1je5P005ObgvFYKTKuGknPtuAM6K4NrfYgrEGu7eOBROkWkPlEpPVOT4qK67EQN3UWDyTtSg__'
                            , 60.0, 60.0, 100.0, BoxFit.fill),
                        11.0.widthBox,
                        AppTextWidget(
                          Strings.orderLocation.tr(context),
                          style: TextStyleHelper.of(context).regular16.copyWith(color: ThemeModel.of(context).font1,fontSize: 20,fontWeight: FontWeight.w800,overflow: TextOverflow.ellipsis),
                          textAlign: TextAlign.start,
                          maxLines: 1,

                        ).expand,


                      ],
                    ),
                    12.h.heightBox,
                  ListView.separated(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>OrderDetailsItem(),
                      separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount: 3)
                  ],
                ),
              ),
            ),


        ],),
      ),
    );
  }
}
class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 13),
      decoration: BoxDecoration(
        color: ThemeModel.of(context).cardsColor,
        borderRadius: BorderRadius.circular(18),


      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          image('https://s3-alpha-sig.figma.com/img/cb59/edd8/c8a22948d62fd86a21170164392d8b48?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=du3khvWHndmvkfEW3vuNlQm7PenUyAhrIP05GSuTN6v2ko8-OeXnCnC47dCRFSA5tNVSlkiMzjAKpZ7SGhP3L8R5m3T-ksq-m62W7z7Yk28VGqcJkUZmIU6KQuvrXIUJPPdznEHKRn7hF8NoqssQL0lQqnYDrxOdyW3WNYrshmAF5apkRaBGcQvq~Q~mTxOeCioc7-MlPjg7AVMsnj-aNv47VINaLSkNbKV1bo6H4QwaJpt4MwbAUAp8gFwnfU1YHOXrsvwebopD0m1je5P005ObgvFYKTKuGknPtuAM6K4NrfYgrEGu7eOBROkWkPlEpPVOT4qK67EQN3UWDyTtSg__'
              , 100.0.h,100.0.w,0.0, BoxFit.fill),
          11.0.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                Strings.orderLocation.tr(context),
                style: TextStyleHelper.of(context).medium14.copyWith(color: ThemeModel.of(context).font1,overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              8.h.heightBox,


              AppTextWidget(
                'Al-Waleed Ibn Hisham Ibn Muawiyah, 4362, Al-Khalidiyah District, 6964, MCKA6946 Mecca 24232, Saudi Arabia, Mecca, Saudi Arabia',
                style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,height: 1.3,overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.start,
                maxLines: 2,

              ),
             10.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                AppTextWidget(
                  "${Strings.quantity.tr(context)} 4",
                  style: TextStyleHelper.of(context).regular12.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w700),

                ),
                  AppTextWidget(
                    "7 ${Strings.sr.tr(context)}",
                    style: TextStyleHelper.of(context).regular12.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w700),

                  ),

              ],)

            ],
          ).expand,

        ],
      ),
    );
  }
}
