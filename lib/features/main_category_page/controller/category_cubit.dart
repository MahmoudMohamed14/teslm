import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Dio/Dio.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../models/categories_provider.dart';
import '../../../models/filter_model.dart';
import '../../../models/offers_model_category.dart';
import 'category_data_handler.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);

  Advertising? offersData;
  void getAdsByCategoryId(String categoryId) async {
    emit(GetAdsByCategoryLoading());
    final result = await CategoryDataHandler.getCategoryAdvertising(categoryId);
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      emit(GetAdsByCategoryError());
    }, (r) {
      offersData = r;
      emit(GetAdsByCategorySuccess());
    });
  }

  bool changeViewNew=false;
  FilterProvidersModel? filterProvideData;
  void filterProvider(String sortField,String sortBy) async {
    emit(FilterProviderLoading());
    final result = await CategoryDataHandler.getFilterProviders(sortField,sortBy);
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      emit(FilterProviderError());
    }, (r) {
      filterProvideData = r;
      emit(CategoryProviderSuccess());
    });
  }

  CategoryProviderModel? categoryProvideData;
  void categoryProvider(String categoryId) async {
    emit(CategoryProviderLoading());
    final result = await CategoryDataHandler.getCategoryProviders(categoryId);
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      emit(CategoryProviderError());
    }, (r) {
      categoryProvideData = r;
      emit(CategoryProviderSuccess());
    });
  }

  void changeView() {
    changeViewNew = !changeViewNew;
    emit(CategoryProviderSuccess());
  }
}
