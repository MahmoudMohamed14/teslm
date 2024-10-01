import 'package:delivery/features/profile/navigator/my_account/controller/account_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Dio/Dio.dart';
import '../../../../../common/constant/constant values.dart';
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
      required BuildContext context}) {
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
    print(data);
    DioHelper.patchData(
      url: 'customers/auth/me',
      token: token,
      data: data,
    ).then((value) {
      getNewCustomer(context);
      emit(UpdateUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserError());
    });
  }

  //   --------------  Get new customer
  GetUserData? getUserData;
  void getNewCustomer(BuildContext context) async {
    print("TOKEN>>>>>>>>>>>>>> ><<<<<<<<<");
    emit(GetUserLoading());
    final result = await AccountDataHandler.getNewCustomer();
    result.fold((l) {
      print("MMMMMMMMMMM>> ${l.errorModel.statusMessage.toString()}");
      emit(GetUserError());
    }, (r) {
      print("RRRRRRRRR>> ${r.name}");
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
