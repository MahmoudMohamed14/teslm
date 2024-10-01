import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
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
  void getPointsAndBalance(){
    emit(GetPointsLoading());
    DioHelper.getData(url: '${ApiEndPoint.wallet}/$customerId',).then((newValue) async {
      balanceAndPointsData=Points.fromJson(newValue.data);
      emit(GetPointsSuccess());
    }).catchError((error){
      print( "eeeeeeeeeeeeeeeeeeee ${error.toString()}");
      emit(GetPointsError());
    });
  }

  GetCouponsModel ?couponsData;
  void getCouponsData(){
    emit(GetCouponsLoading());
    DioHelper.getData(url:ApiEndPoint.coupons,query: {
      "customerId":"$customerId"
    }).then((value) async {
      couponsData=GetCouponsModel.fromJson(value.data);
      emit(GetCouponsSuccess());
    }).catchError((error){
      emit(GetCouponsError());
    });
  }

  void redeemPointsCustomer(context){
    emit(RedeemPointsLoading());
    DioHelper.postData(url: '${ApiEndPoint.wallet}/$customerId/${ApiEndPoint.redeemPoints}',).then((value) {
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
    });
  }
  void getPointsCustomer(){
    emit(GetUserPointsLoading());
    DioHelper.getData(url: '${ApiEndPoint.coupons}/$customerId',
        token: token,
    ).then((value) async{
      emit(GetUserPointsSuccess());
    }).catchError((error) {
      emit(GetUserPointsError());
    });
  }
}
