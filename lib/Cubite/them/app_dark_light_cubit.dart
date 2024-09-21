import 'package:bloc/bloc.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_dark_light_state.dart';

class AppDarkLightCubit extends Cubit<AppDarkLightState> {
  AppDarkLightCubit() : super(AppDarkLightInitial());
  static AppDarkLightCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeapppmode({bool? formshare}) {
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
  /*getCurrentTheme() {
    isDark = Save.getdata(key: 'isDark');
  }*/
}
