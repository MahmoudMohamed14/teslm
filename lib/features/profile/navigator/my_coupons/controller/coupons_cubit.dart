import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../point/controller/point_cubit.dart';
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
      PointCubit.get(context).getPointsAndBalance();
      PointCubit.get(context).getCouponsData();
      emit(GetCouponsSuccess());
    });
  }
}
