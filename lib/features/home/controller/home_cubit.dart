import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Dio/Dio.dart';
import '../../../models/Categories model.dart';
import '../../../models/offers model.dart';
import '../../../models/provider model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int current = 0;

  void changeNavigator(int index) {
    current = index;
    emit(Reload());
  }

  Advertising? offersData;
  void offers(){
    emit(OffersLoading());
    DioHelper.getData(url: 'ads',
      myapp: true,
    ).then((value) {
      offersData=Advertising.fromJson(value.data);
      emit(OffersSuccess());
    }).catchError((error) {
      emit(OffersError());
    });
  }

  List<Categories> ?categoryData;
  void category() {
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories', myapp: true)
        .then((value) {
      final List<dynamic> categories = value.data;
      categoryData = categories.map((item) => Categories.fromJson(item)).toList();
      emit(CategoriesSuccess());
    }).catchError((error) {
      emit(CategoriesError());
    });
  }

  ProviderHome? providerData;
  void getProviderData(){
    emit(GetProviderLoading());
    DioHelper.getData(url:'providers/home',
        myapp: true
    ).then((value) {
      providerData = ProviderHome.fromJson(value.data);
      emit(GetProviderSuccess());
    }).catchError((error) {
      emit(GetProviderError());
    });
  }
}
