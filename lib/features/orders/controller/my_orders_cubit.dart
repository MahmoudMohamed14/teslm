
import 'package:delivery/features/orders/controller/my_order_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/customer_orders_model.dart';

part 'my_order_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(OrderInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);

  CustomerOrders? customerOrders;
  Future<void> getCustomerOrders() async {
    emit(GetOrdersLoading());
    final result = await OrderDataHandler.getCustomerOrders();

    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(GetOrdersError());
    }, (r) {
      customerOrders=r;
      print('heeeeeeeeeeeeeeeeeeee');
      print(r.data?.firstOrNull?.items?.firstOrNull?.toJson());

      emit(GetOrdersSuccess());
    });
    /*DioHelper.getData(url: ApiEndPoint.myOrders,
      token: token,
    ).then((value) {
      customerOrders=CustomerOrders.fromJson(value.data);
      print(value.data);
      emit(GetOrdersSuccess());
    }).catchError((error) {
      emit(GetOrdersError());
    });*/
  }
}
