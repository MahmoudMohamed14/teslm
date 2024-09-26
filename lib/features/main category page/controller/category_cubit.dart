import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Dio/Dio.dart';
import '../../../models/categories provider.dart';
import '../../../models/filter model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);
  bool changeViewNew=true;
  FilterProviders? filterProvideData;
  void filterProvider({id,sortField,sortBy}) {
    emit(FilterProviderLoading());
    DioHelper.getData(url: 'providers/customers?sortOrder=$sortField&sortField=$sortBy', myapp: true)
        .then((value) {
      filterProvideData = FilterProviders.fromJson(value.data);
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print('providers/customers?sortOrder=DESC&sortField=$sortBy');
      print(error.toString());
      emit(FilterProviderError());
    });
  }
  CategoryProviderModel? categoryProvideData;
  void categoryProvider({id}) {
    emit(CategoryProviderLoading());
    DioHelper.getData(url: 'categories/$id', myapp: true)
        .then((value) {
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
