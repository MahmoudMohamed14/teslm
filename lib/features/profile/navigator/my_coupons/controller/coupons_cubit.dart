import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/translate/strings.dart';
import '../Models/get_coupons_model.dart';
import 'coupons_data_handler.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  CouponsCubit() : super(CouponsInitial());

  static CouponsCubit get(context) => BlocProvider.of(context);

  //   --------------  Get new customer
  GetCouponsModel? couponsData;
  void getUserCoupons(BuildContext context) async {
    emit(GetCouponsLoading());
    final result = await CouponsDataHandler.getUserCoupons();
    result.fold((l) {
      emit(GetCouponsError());
    }, (r) {
      couponsData = r;
      print("couponsData is ${couponsData?.data?.length}");
      emit(GetCouponsSuccess());
    });
  }

  void saveCoupons(BuildContext context,String code) async {
    emit(SaveCouponsLoading());
    final result = await CouponsDataHandler.saveCoupon(couponCode: code);
    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponNotValid.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
      Navigator.pop(context);
      emit(SaveCouponsError());
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade500,
        content:  Align(
            alignment: Alignment.center,child: Text(Strings.couponAddSuccessfully.tr(context),
          style:const TextStyle(color: Colors.white),)),
      ));
      print("couponsData is ${couponsData?.data?.length}");
      Navigator.pop(context);
      getUserCoupons(context);
      emit(SaveCouponsSuccess());
    });
  }
}
