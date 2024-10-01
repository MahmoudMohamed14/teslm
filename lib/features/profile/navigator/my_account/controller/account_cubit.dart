import 'package:delivery/features/profile/navigator/my_account/controller/account_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/get_user_data.dart';
import '../../../../point/controller/point_cubit.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  static AccountCubit get(context) => BlocProvider.of(context);

  void userUpdate(
      {String? username,
      String? email,
      String? birthdate,
      required BuildContext context}) async {
    emit(UpdateUserLoading());
    Map<String, dynamic> data =
        {}; // Create an empty map to hold the updated data
    if (username != null) {
      data['name'] = username;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (birthdate != null) {
      data['birthdate'] = birthdate;
    }
    // print(data);
    final result = await AccountDataHandler.updateUser(bodyJson: data);
    result.fold((l) {
      emit(UpdateUserError());
    }, (r) {
      getNewCustomer(context);
      emit(UpdateUserSuccess());
    });
  }

  //   --------------  Get new customer
  GetUserData? getUserData;
  void getNewCustomer(BuildContext context) async {
    emit(GetUserLoading());
    final result = await AccountDataHandler.getNewCustomer();
    result.fold((l) {
      emit(GetUserError());
    }, (r) {
      getUserData = r;
      PointCubit.get(context).getPointsAndBalance();
      PointCubit.get(context).getCouponsData();
      emit(GetUserSuccess());
    });
    // DioHelper.getData(url: 'customers/auth/me',
    //     token: token,
    // ).then((value) async{
    //   getUserData=GetUserData.fromJson(value.data);
    //   PointCubit.get(context).getPointsAndBalance();
    //   PointCubit.get(context).getCouponsData();
    //   emit(GetUserSuccess());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(GetUserError());
    // });
  }
}
