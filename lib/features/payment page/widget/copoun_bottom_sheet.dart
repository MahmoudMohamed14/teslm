import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/payment%20page/function/check_copoun.dart';
import 'package:delivery/features/profile/navigator/my_coupons/controller/coupons_cubit.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/images/images.dart';
import '../controller/order_cubit.dart';


class CouponsBottomSheet extends StatefulWidget {
  final TextEditingController couponsController;

  const CouponsBottomSheet({super.key,required this.couponsController});
  @override
  CouponsBottomSheetState createState() => CouponsBottomSheetState();
}

class CouponsBottomSheetState extends State<CouponsBottomSheet> {
  final ScrollController _bottomSheetController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ProviderCubit.get(context);
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height /2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _bottomSheetController,
                  itemCount: CouponsCubit.get(context).couponsData?.data?.length,
                  itemBuilder: (context, index) {
                    return CouponsCubit.get(context).couponsData?.data?[index].status=="ACTIVE"?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          OrderCubit.get(context).getCoupon(context,value: CouponsCubit.get(context).couponsData?.data?[index]);
                       Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ThemeModel.of(context).bigCardBottomColor),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  backgroundColor: ThemeModel.of(context).backgroundCouponColor,
                                  radius: 20,
                                  child: SvgPicture.asset(
                                    width: 25.w,
                                    height: 25.h,
                                    ImagesApp.couponImage,
                                  )),
                              const SizedBox(width: 10,),
                              Flexible(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(CouponsCubit.get(context).couponsData?.data?[index].code??"",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                  Row(
                                    children: [
                                      Text(
                                        Strings.maxDiscount.tr(context),
                                        style: TextStyle(color: ThemeModel.of(context).maxAmountCouponColor),
                                      ),
                                      Text(
                                        ' ${CouponsCubit.get(context).couponsData?.data?[index].maxAmount ?? 0} ',
                                        style: TextStyle(color: ThemeModel.of(context).maxAmountCouponColor),
                                      ),
                                      Text(
                                        Strings.sr.tr(context),
                                        style: TextStyle(color: ThemeModel.of(context).maxAmountCouponColor),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              const SizedBox(width: 10,),
                              Text(
                                CouponsCubit.get(context).couponsData?.data?[index].percentageAmount != null
                                    ? "${CouponsCubit.get(context).couponsData?.data?[index].percentageAmount.toString()} % "
                                    : "${CouponsCubit.get(context).couponsData?.data?[index].fixedAmount.toString()} SR",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ],),
                        ),
                      ),
                    ):Container();
                  }),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BottomWidget(Strings.addCoupon.tr(context), () {
                enterCoupon(context,widget.couponsController);
              }),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
