import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/categories_model.dart';
import '../../../models/offers_model.dart';
import '../../../models/provider_model.dart';
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
  void offers() async {
    emit(OffersLoading());
    final result = await HomeDataHandler.getAdvertisingHome();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");
      emit(OffersError());
    }, (r) {
      offersData = r;
      emit(OffersSuccess());
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

  ProviderHome? providerData;
  void getProviderData() async {
    emit(GetProviderLoading());
    final result = await HomeDataHandler.getProvidersHome();
    result.fold((l) {
      print("error issssssssssss ${l.errorModel.statusMessage}");
      emit(GetProviderError());
    }, (r) {
      providerData = r;
      emit(GetProviderSuccess());
    });
  }

}
