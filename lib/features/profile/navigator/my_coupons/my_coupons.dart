import 'package:delivery/common/components.dart';
import 'package:delivery/common/translate/app_local.dart';
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

class _MyCouponsState extends State<MyCoupons> {
  @override
  void initState() {
    super.initState();
    CouponsCubit.get(context).getUserCoupons(
        context); // Call the Cubit method to fetch data in initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsCubit, CouponsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: appBarWithIcons(Strings.myCoupons.tr(context),
                  ImagesApp.pointsAppBarImage, true, context)),
          body: SizedBox(
            child: Center(
                child: CouponsCubit.get(context).couponsData == null
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: CouponsCubit.get(context)
                                .couponsData
                                ?.data
                                ?.length ??
                            0,
                        itemBuilder: (context, index) => VoucherCard(
                          coupon: CouponsCubit.get(context)
                              .couponsData
                              ?.data?[index],
                        ),
                      )),
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
        color: Colors.white,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.brown,
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
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8.0),

          // Validity date and "Expired" label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Valid until 25.05.2024',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  coupon?.status ?? "",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Payment option
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              coupon?.appliedOn ?? "",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
