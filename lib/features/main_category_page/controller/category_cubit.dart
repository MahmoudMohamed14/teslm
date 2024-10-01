import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Dio/Dio.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories provider.dart';
import '../../../models/filter model.dart';
import '../../../models/offers model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);
  bool changeViewNew=true;
  FilterProviders? filterProvideData;
  void filterProvider({id,sortField,sortBy}) {
    emit(FilterProviderLoading());
    DioHelper.getData(url: '${ApiEndPoint.providersCustomers}?sortOrder=$sortField&sortField=$sortBy',)
        .then((value) {
      filterProvideData = FilterProviders.fromJson(value.data);
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print('${ApiEndPoint.providersCustomers}?sortOrder=DESC&sortField=$sortBy');
      print(error.toString());
      emit(FilterProviderError());
    });
  }
  Advertising? offersData;
  void getAdsByCategoryId(String id){
    offersData=null;
    emit(GetAdsByCategoryLoading());
    DioHelper.getData(url: "${ApiEndPoint.getAdsByCategory}/$id",
    ).then((value) {
      offersData=Advertising.fromJson(value.data);
      print(" done${offersData?.data?.firstOrNull?.provider?.categories?.firstOrNull?.name?.ar}");
      emit(GetAdsByCategorySuccess());
    }).catchError((error) {
      emit(GetAdsByCategoryError());
    });
  }
  CategoryProviderModel? categoryProvideData;
  void categoryProvider({id}) {
    emit(CategoryProviderLoading());
    DioHelper.getData(url: '${ApiEndPoint.categories}/$id',)
        .then((value) {
      print('CategoryProvider${ApiEndPoint.categories}/$id');
      categoryProvideData = CategoryProviderModel.fromJson(value.data);
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryProviderError());
    });
  }
  void changeView() {
    changeViewNew = !changeViewNew;
    emit(CategoryProviderSuccess());
  }
}
