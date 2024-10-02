import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:delivery/features/point/controller/point_data_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/get_coupons_model.dart';
import '../../../models/get_user_data.dart';
import '../../../shared_preference/shared preference.dart';

part 'point_state.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit() : super(PointInitial());
  static PointCubit get(context) => BlocProvider.of(context);
  Points ?balanceAndPointsData;
  Future<void> getPointsAndBalance() async {
    emit(GetPointsLoading());
    final result = await PointDataHandler.getPointsAndBalance();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(GetPointsError());
    }, (r) {
      balanceAndPointsData=r;
      emit(GetPointsSuccess());
    });
  }

  GetCouponsModel ?couponsData;
  Future<void> getCouponsData() async {
    emit(GetCouponsLoading());
    final result = await PointDataHandler.getCouponsData();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(GetCouponsError());
    }, (r) {
      couponsData=r;
      emit(GetCouponsSuccess());
    });
  }

  Future<void> redeemPointsCustomer(context) async {
    emit(RedeemPointsLoading());
    final result = await PointDataHandler.redeemPointsCustomer();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      if(balanceAndPointsData!.points!<10000){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade600,
          content:  Align(
              alignment: Alignment.center,child: Text(Strings.yourPointsLess.tr(context),
            style:const TextStyle(color: Colors.white,),)),
        ));}else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content:  Align(
              alignment: Alignment.center,child: Text(Strings.failedRedeemPoints.tr(context),
            style:const TextStyle(color: Colors.white,),)),
        ));
      }
      emit(RedeemPointsError());
    }, (r) {
      if(r){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
            alignment: Alignment.center,child: Text(Strings.pointsRedeemedSuccessfully.tr(context),
          style:const TextStyle(color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
        getPointsAndBalance();
        getCouponsData();
        emit(RedeemPointsSuccess());
      }else{
        if(balanceAndPointsData!.points!<10000){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade600,
            content:  Align(
                alignment: Alignment.center,child: Text(Strings.yourPointsLess.tr(context),
              style:const TextStyle(color: Colors.white,),)),
          ));}else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade500,
            content:  Align(
                alignment: Alignment.center,child: Text(Strings.failedRedeemPoints.tr(context),
              style:const TextStyle(color: Colors.white,),)),
          ));
        }
      }


    });
   /* DioHelper.postData(url: '${ApiEndPoint.wallet}/$customerId/${ApiEndPoint.redeemPoints}',).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(Strings.pointsRedeemedSuccessfully.tr(context),
        style:const TextStyle(color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      getPointsAndBalance();
      getCouponsData();
      emit(RedeemPointsSuccess());
    }).catchError((error) {
      if(balanceAndPointsData!.points!<10000){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade600,
          content:  Align(
              alignment: Alignment.center,child: Text(Strings.yourPointsLess.tr(context),
            style:const TextStyle(color: Colors.white,),)),
        ));}else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content:  Align(
              alignment: Alignment.center,child: Text(Strings.failedRedeemPoints.tr(context),
            style:const TextStyle(color: Colors.white,),)),
        ));
      }
      emit(RedeemPointsError());
    });*/
  }
  void getPointsCustomer(){
    emit(GetUserPointsLoading());
    DioHelper.getData(url: '${ApiEndPoint.coupons}/$customerId', token: token,).then((value) async{
      emit(GetUserPointsSuccess());
    }).catchError((error) {
      emit(GetUserPointsError());
    });
  }
}
