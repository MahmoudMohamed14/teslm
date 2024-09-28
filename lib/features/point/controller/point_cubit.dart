import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/common/translate/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
import '../../../common/constant/api_end_points.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/get coupons model.dart';
import '../../../models/get user data.dart';
import '../../../shared_preference/shared preference.dart';

part 'point_state.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit() : super(PointInitial());
  static PointCubit get(context) => BlocProvider.of(context);
  Points ?balanceAndPointsData;
  void getPointsAndBalance(){
    emit(GetPointsLoading());
    DioHelper.getData(url: '${ApiEndPoint.wallet}/$customerId',myapp: true).then((newValue) async {
      balanceAndPointsData=Points.fromJson(newValue.data);
      balances=await Save.savedata(key: 'balance',value:balanceAndPointsData!.balance);
      emit(GetPointsSuccess());
    }).catchError((error){
      emit(GetPointsError());
    });
  }

  GetCoupons ?couponsData;
  void getCouponsData(){
    emit(GetCouponsLoading());
    DioHelper.getData(url:ApiEndPoint.coupons,myapp: true,query: {
      "customerId":"$customerId"
    }).then((value) async {
      couponsData=GetCoupons.fromJson(value.data);
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
        myapp: true
    ).then((value) async{
      emit(GetUserPointsSuccess());
    }).catchError((error) {
      emit(GetUserPointsError());
    });
  }
}
