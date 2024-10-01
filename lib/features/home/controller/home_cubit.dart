import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_model.dart';
import '../../../models/offers_model.dart';
import '../../../models/provider_model.dart';
import '../../auth/controller/auth_data_handler.dart';
import 'home_data_handler.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int current = 0;

  void changeNavigator(int index) {
    current = index;
    emit(Reload());
  }

  AdvertisingModel? offersData;
  void offers(){
    emit(OffersLoading());
    DioHelper.getData(url: ApiEndPoint.ads,
    ).then((value) {
      offersData=AdvertisingModel.fromJson(value.data);
      offersData = AdvertisingModel.fromJson(value.data);
      // print(" offersData${offersData?.data?.firstOrNull?.provider?.categories?.firstOrNull?.name?.ar}");
      emit(OffersSuccess());
    }).catchError((error) {
      emit(OffersError());
    });
  }

  List<CategoriesModel>? categoryData;
  void category() async {
    emit(CategoriesLoading());
    final result = await HomeDataHandler.getCategoryHome();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      emit(CategoriesError());
    }, (r) {
      print("categories is ${r.first.name?.en}");
      categoryData = r;
      emit(CategoriesSuccess());
    });
  }
  /*void category() {
    emit(CategoriesLoading());
    DioHelper.getData(url: ApiEndPoint.categories,)
        .then((value) {
      final List<dynamic> categories = value.data;
      categoryData = categories.map((item) => Categories.fromJson(item)).toList();
      emit(CategoriesSuccess());
    }).catchError((error) {
      emit(CategoriesError());
    });
  }*/


  ProviderHome? providerData;
  void getProviderData() {
    emit(GetProviderLoading());
    DioHelper.getData(
      url: ApiEndPoint.providersHome,
    ).then((value) {
      providerData = ProviderHome.fromJson(value.data);
      emit(GetProviderSuccess());
    }).catchError((error) {
      emit(GetProviderError());
    });
  }
}
