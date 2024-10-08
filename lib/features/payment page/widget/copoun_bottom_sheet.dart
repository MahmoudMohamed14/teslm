import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/profile/navigator/my_coupons/controller/coupons_cubit.dart';
import 'package:delivery/features/provider%20page/controller/provider_cubit.dart';
import 'package:flutter/material.dart';


class CouponsBottomSheet extends StatefulWidget {
  @override
  const CouponsBottomSheet({super.key});
  @override
  CouponsBottomSheetState createState() => CouponsBottomSheetState();
}

class CouponsBottomSheetState extends State<CouponsBottomSheet> {
  Color containerColor = Colors.white;
  final ScrollController _bottomSheetController = ScrollController();
  late AnimationController controller;

  int totalExtraPrice = 0;
  String extraName = '';
  late double imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
  List<List<bool>> checklist = [];

  void changeChecklistValue(int checklistIndex, int itemIndex, bool value) {
    setState(() {
      checklist[checklistIndex][itemIndex] =
      !checklist[checklistIndex][itemIndex];
    });
  }

  int getTrueCountAtIndex(int index) {
    return checklist[index].where((value) => value).length;
  }

  @override
  void initState() {
    super.initState();
  }

  void bottomSheetScroll() {
    setState(() {
      if (_bottomSheetController.offset > 20 &&
          _bottomSheetController.offset < 32) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4 -
            _bottomSheetController.offset * 2.5;
      } else if (_bottomSheetController.offset <= 25) {
        imageBottomSheetHeight = MediaQuery.sizeOf(context).height / 4;
      }
    });
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
          maxHeight: MediaQuery.of(context).size.height - 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                Strings.myCoupons.tr(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _bottomSheetController,
                  itemCount: CouponsCubit.get(context).couponsData?.data?.length,
                  itemBuilder: (context, index) {
                    return Container();
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
