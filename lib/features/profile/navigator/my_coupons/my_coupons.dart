import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/profile/navigator/my_coupons/widget/check_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/images/images.dart';
import '../../../../common/translate/strings.dart';
import 'Models/get_coupons_model.dart';
import 'controller/coupons_cubit.dart';

class MyCoupons extends StatefulWidget {
  const MyCoupons({super.key});

  @override
  State<MyCoupons> createState() => _MyCouponsState();
}

class _MyCouponsState extends State<MyCoupons> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    CouponsCubit.get(context).getUserCoupons(
        context); // Call the Cubit method to fetch data in initState
  }
  late TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsCubit, CouponsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final TextEditingController couponController = TextEditingController();
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: appBarWithIcons(Strings.myCoupons.tr(context),
                  ImagesApp.pointsAppBarImage, true, context)),
          body: DefaultTabController(
            length: 2,
            child: SizedBox(
              child: Center(
                  child: CouponsCubit.get(context).couponsData == null
                      ? const CircularProgressIndicator()
                      : Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Expanded(child: Tab(text: 'ACTIVE')),
                              Expanded(child: Tab(text: 'DRAFT')),
                            ],
                            indicatorColor: Colors.blue,  // Customize TabBar as needed
                            labelColor: ThemeModel.mainColor,

                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children:[ ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: CouponsCubit.get(context)
                                          .couponsData
                                          ?.data
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) =>CouponsCubit.get(context)
                                      .couponsData?.data?[index].status=="ACTIVE"? VoucherCard(
                                    coupon: CouponsCubit.get(context)
                                        .couponsData
                                        ?.data?[index],
                                  ):Container(),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: CouponsCubit.get(context)
                                      .couponsData
                                      ?.data
                                      ?.length ??
                                      0,
                                  itemBuilder: (context, index) =>CouponsCubit.get(context)
                                      .couponsData?.data?[index].status!="ACTIVE"? VoucherCard(
                                    coupon: CouponsCubit.get(context)
                                        .couponsData
                                        ?.data?[index],
                                  ):Container(),
                                )
                              ],
                            ),
                          ),
                         const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: BottomWidget(Strings.addCoupon.tr(context), () {
                              saveCoupon(context,couponController,true);
                            }),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      )),
            ),
          ),
        );
      },
    );
  }
}

class VoucherCard extends StatelessWidget {
  final CouponData? coupon;
  const VoucherCard({super.key, this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ThemeModel.of(context).cardsColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with discount text and percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  coupon?.code ?? "",
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ThemeModel.of(context).textCouponColor,
                  ),
                ),
              ),
              Text(
                coupon?.percentageAmount != null
                    ? "${coupon?.percentageAmount.toString()} % "
                    : "${coupon?.fixedAmount.toString()} SR",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Max discount info
          Text(
            'Max discount of ${coupon?.maxAmount ?? 0} SR',
            style: TextStyle(color: ThemeModel.of(context).maxAmountCouponColor),
          ),
          const SizedBox(height: 8.0),

          // Validity date and "Expired" label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              coupon?.endDate!=null?
               Text(
                'Valid until ${coupon?.endDate ?? ""}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ):Container(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color:coupon?.status=="ACTIVE"? Colors.green[300]:Colors.red[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  coupon?.status ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Payment option
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: ThemeModel.mainColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              coupon?.appliedOn ?? "",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
