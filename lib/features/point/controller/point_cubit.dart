import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
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
    DioHelper.getData(url: 'wallet/$customerId',myapp: true).then((newValue) async {
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
    DioHelper.getData(url: 'coupons',myapp: true,query: {
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
    DioHelper.postData(url: 'wallet/$customerId/redeem-points',).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(language=='English Language'?'Your points has been redeemed successfully':"تم استبدال نقاطك بنجتح",
        style:const TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      getPointsAndBalance();
      getCouponsData();
      emit(RedeemPointsSuccess());
    }).catchError((error) {
      if(balanceAndPointsData!.points!<10000){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade600,
          content:  Align(
              alignment: Alignment.center,child: Text(language=='English Language'?"Your points less than 10,000":'نقاطك اقل من 10,000',
            style:const TextStyle(color: Colors.white,fontSize: 17),)),
        ));}else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content:  Align(
              alignment: Alignment.center,child: Text(language=='English Language'?"Failed to redeem your points":'فشلت عملية استبدال نقاطك',
            style:const TextStyle(color: Colors.white,fontSize: 17),)),
        ));
      }
      emit(RedeemPointsError());
    });
  }
  void getPointsCustomer(){
    emit(GetUserPointsLoading());
    DioHelper.getData(url: 'coupons/$customerId',
        token: token,
        myapp: true
    ).then((value) async{
      emit(GetUserPointsSuccess());
    }).catchError((error) {
      emit(GetUserPointsError());
    });
  }
}
