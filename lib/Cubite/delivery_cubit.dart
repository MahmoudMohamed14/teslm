import 'dart:async';
import 'dart:convert';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../common/components.dart';
import '../models/customer orders model.dart';
import '../shared_preference/shared preference.dart';
part 'delivery_state.dart';


class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial()){}
  double opecity=1;
  /*  scrollControllerColumn.addListener(_onScroll);
    scrollControllerColumn.addListener(_scrollAnimation);*/
   /* if(providerFoodData!=null)
    _calculateListOffsets();
  }*/
  //============Resturant=================
/*  final ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  final ItemScrollController itemScrollController = ItemScrollController();

  int currentIndex = 0;*/
  //======================================
  static DeliveryCubit get(context) => BlocProvider.of(context);
  void increment(){
    emit(Reload());
  }
  //===============resturant=============



  List<bool> isCheckedList =[ true,false,false];
  bool choosePadding =true;

  void changePaymentMethod(index){
    if(index==1){isCheckedList=[false,true,false];emit(Reload());}
    else if(index==2){isCheckedList=[false,false,true];emit(Reload());}
    else {isCheckedList=[true,false,false];emit(Reload());}
    choosePadding =false;
  Timer(Duration(milliseconds: 350), () {
    choosePadding = true;
    emit(Reload());
  });
}

  /*void userInvitation(context){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/generate-invitation-code', token: token, data: {}).then((value) {
      AuthCubit.get(context).loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=AuthCubit.get(context).loginOTP!.token;
      emit(LoginOTPSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginOTPError());
    });
  }*/



  CustomerOrders? customerOrders;
  void getCustomerOrders(){
    emit(GetOrdersLoading());
    DioHelper.getData(url: 'orders/customer',
      token: token,
      myapp: true,
    ).then((value) {
      customerOrders=CustomerOrders.fromJson(value.data);
      print(value.data);
      emit(GetOrdersSuccess());
    }).catchError((error) {
      print('tttttttttttttttttttttt ${error.toString()}');
      emit(GetOrdersError());
    });
  }
}

