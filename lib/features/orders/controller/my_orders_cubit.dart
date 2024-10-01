import 'package:delivery/common/end_points_api/api_end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/customer_orders model.dart';

part 'my_order_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(OrderInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  CustomerOrders? customerOrders;
  void getCustomerOrders(){
    emit(GetOrdersLoading());
    DioHelper.getData(url: ApiEndPoint.myOrders,
      token: token,
    ).then((value) {
      customerOrders=CustomerOrders.fromJson(value.data);
      print(value.data);
      emit(GetOrdersSuccess());
    }).catchError((error) {
      emit(GetOrdersError());
    });
  }
}
