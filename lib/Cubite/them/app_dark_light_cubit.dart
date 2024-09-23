import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_preference/shared preference.dart';
part 'app_dark_light_state.dart';

class AppDarkLightCubit extends Cubit<AppDarkLightState> {
  AppDarkLightCubit() : super(AppDarkLightInitial());
  static AppDarkLightCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode({bool? formShare}) {
      isDark = !isDark;
      Save.putdata(key: 'isDark', value: isDark).then((value) =>
          emit(ChangeMode()));
  }
  String lang='ar';
  void changeLang({fromCache,lange}){
    if (fromCache != null) {
      lang = fromCache;
      emit(ChangeLangStatesApp());
    } else {
      lang= lange;
      language=lang;
      Save.savedata(key: 'lang', value: lange).then((value) {});
      emit(ChangeLangStatesApp());
     }
  }
}
