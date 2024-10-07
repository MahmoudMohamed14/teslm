import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import '../../../common/text_style_helper.dart';
import '../../../common/translate/strings.dart';
import '../../../models/customer_orders model.dart';
import '../../home/screens/home.dart';
import '../../map_page/controller/map_cubit.dart';


class NewOrderDetails extends StatelessWidget {
  const NewOrderDetails({super.key, this.orderData});
 final OrderData? orderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(98.0),
        child: appBarWithIcons(Strings.delivery.tr(context),

            ImagesApp.clockImageAppBar, true, context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                Strings.estimatedArrivalTime.tr(context),
                style: TextStyleHelper.of(context).bold20.copyWith(color: ThemeModel.of(context).font1),

              ),
              10.h.heightBox,
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: .5,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: ThemeModel.of(context).greenAppBar,
                    borderRadius: BorderRadius.circular(18),


                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:ThemeModel.of(context).pointBigCardColor ,
                              radius: 15,
                              child: Center(child: SvgPicture.asset(ImagesApp.clockImage,colorFilter: ColorFilter.mode(ThemeModel.of(context).font1, BlendMode.srcIn),)),
                            ),
                            11.0.widthBox,
                            AppTextWidget(
                               "6 ${Strings.minutes.tr(context)}",
                              style: TextStyleHelper.of(context).bold20.copyWith(color: Colors.white,fontSize: 24),

                            ),
                            8.0.widthBox,
                            AppTextWidget(
                              Strings.toYourOrderArrival.tr(context),
                              style: TextStyleHelper.of(context).medium14.copyWith(color: Colors.white),

                            ),
                          ],
                        ),
                      ),
                      15.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: ThemeModel.of(context).pendingColor,
                              borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(30),
                                  bottomEnd: Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisSize:  MainAxisSize.min,

                              children: [
                                AppTextWidget(
                                  '${Strings.driverName.tr(context)} :',
                                  style: TextStyleHelper.of(context)
                                      .medium14
                                      .copyWith(color: ThemeModel.of(context).font1),
                                ),
                                5.w.widthBox,
                                SizedBox(
                                  width: 130.w,
                                  child: AppTextWidget(
                                    maxLines: 1,
                                  textAlign: TextAlign.start,
                                  orderData?.deliveryPartner?.name??'',
                                    style: TextStyleHelper.of(context)
                                        .bold19
                                        .copyWith(color: ThemeModel.of(context).font1,overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 13.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: (){
                                    makePhoneCall(orderData?.deliveryPartner?.phoneNumber??'');

                                  },
                                    child: SvgPicture.asset(ImagesApp.phoneIcon,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),
                                10.w.widthBox,
                                InkWell(
                                  onTap: (){
                                    openWhatsAppChat(orderData?.deliveryPartner?.phoneNumber??'');

                                  },
                                    child: SvgPicture.asset(ImagesApp.whatsAppSvg,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),
                                10.w.widthBox,
                                SvgPicture.asset(ImagesApp.messageSvg,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
                              ],
                            ),
                          )
                        ],
                      ),
                      15.h.heightBox,
                        if(orderData?.status=='pending')   Padding(
                        padding:const EdgeInsetsDirectional.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width-50.w,
                          child: Transform.flip(
                            flipX: language == 'en' ? false : true,
                            child: Column(
                              crossAxisAlignment: language == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [

                                SvgPicture.asset(ImagesApp.logoSvg,),
                                LinearPercentIndicator(
                                  width: MediaQuery.sizeOf(context).width-70.w,
                                  lineHeight:5,

                                  percent: .8,
                                  barRadius: const Radius.circular(8),
                                  progressColor: ThemeModel.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                        else Center(
                          child: Padding(
                            padding:const EdgeInsetsDirectional.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                AppTextWidget(
                                  '${Strings.yourOrderHasArrived.tr(context)} ',
                                  style: TextStyleHelper.of(context)
                                      .medium14
                                      .copyWith(color: Colors.white),
                                ),
                                SvgPicture.asset(ImagesApp.logoSvg,width: 40,height: 40,fit: BoxFit.cover,),

                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              24.h.heightBox,
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
                    InkWell(
                        onTap: (){
                          pageController=PageController(initialPage: 2);
                          navigate(context, const Home());},
                      child: Container(
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
                            MapCubit.get(context).currentLocationName??'',
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
                          image(orderData?.providerOrders?.providerImage??''
                              , 60.0, 60.0, 100.0, BoxFit.fill),
                          11.0.widthBox,
                          AppTextWidget(
                              language == 'en'?  orderData?.providerOrders?.providerName?.en ?? '' : orderData?.providerOrders?.providerName?.ar ?? '',
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
                        itemBuilder: (context,index)=>OrderDetailsItem(item: orderData?.items?[index],),
                        separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount:orderData?.items?.length??0)
                    ],
                  ),
                ),
              ),


          ],),
        ),
      ),
    );
  }
}
class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({super.key, this.item});
  final Items? item;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 13),
      decoration: BoxDecoration(
        color: ThemeModel.of(context).pendingColor,
        borderRadius: BorderRadius.circular(18),


      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          image(item?.image??''
              , 100.0.h,100.0.w,0.0, BoxFit.fill),
          11.0.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                language == 'en'?  item?.item?.name?.en ?? '' : item?.item?.name?.ar ?? '',
                style: TextStyleHelper.of(context).medium14.copyWith(color: ThemeModel.of(context).font1,overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              8.h.heightBox,


              AppTextWidget(
                  language == 'en'?  item?.item?.description?.en ?? '' : item?.item?.description?.ar ?? '',
                style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).font1,height: 1.3,overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.start,
                maxLines: 2,

              ),
             10.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                AppTextWidget(
                  "${Strings.quantity.tr(context)} ${item?.quantity??''}",
                  style: TextStyleHelper.of(context).regular12.copyWith(color: ThemeModel.of(context).font1,fontWeight: FontWeight.w700),

                ),
                  AppTextWidget(
                    "${item?.price??''} ${Strings.sr.tr(context)}",
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
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
Future<void> openWhatsAppChat(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}