import 'package:delivery/Cubite/material_cubit/auth_cubit.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/features/profile/navigator/chat/controller/chat_controller_cubit.dart';
import 'package:delivery/shared_preference/shared%20preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Cubite/them/app_dark_light_cubit.dart';
import 'Cubite/delivery_cubit.dart';
import 'bloc_observer.dart';
import 'common/translate/app_local.dart';
import 'features/home/screens/home.dart';
import 'features/onboarding/screen/onboarding.dart';
import 'features/splash/screen/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Save.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBzyVkj9qekmoRKMOqRz1C0X506z82aXYc", // paste your api key here
      appId: "1:846687732996:android:7377921fed5088f96dfc51", //paste your app id here
      messagingSenderId: "1086097786847", //paste your messagingSenderId here
      projectId: "delivery-c021a", //paste your project id here
    ),
  );
  bool? onboard = Save.getdata(key: 'save');
  token = Save.getdata(key: 'token');
  print(token);
  print(customerId);
  Widget widget;
  if (onboard != null&&onboard!=false) {
    widget = const Home();
  } else {
    widget = const OnBoarding();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(Splash(home: widget)));
}

class MyApp extends StatelessWidget {
  const MyApp(this.start, {Key? key}) : super(key: key);
  final Widget start;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeliveryCubit>(
          create: (context) => DeliveryCubit()..getNewCustomer()..offers()..category()..getProviderData()..getPointsAndBalance()..getCouponsData()..getCustomerOrders(),
        ),
        BlocProvider<AppDarkLightCubit>(
          create: (context) => AppDarkLightCubit()..changeLang(fromCache: language??'ar'),
        ),
        BlocProvider<ChatControllerCubit>(
          create: (context) => ChatControllerCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),

        child: BlocBuilder<AppDarkLightCubit, AppDarkLightState>(
          builder: (context, state) {
           // AppDarkLightCubit.get(context).getCurrentTheme();
            return MaterialApp(
              theme: lightMode,
              debugShowCheckedModeBanner: false,
              darkTheme: darkMode,
              themeMode: isDark??false ? ThemeMode.dark : ThemeMode.light,
              home: start,
              locale:Locale(AppDarkLightCubit.get(context).lang),

             localizationsDelegates:const  [
               AppLocale.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales:const [
                Locale('ar'), // Arabic
                Locale('en'), // English
              ],
              localeResolutionCallback: (currentLang,supportedLang){
                if(currentLang!=null){
                  for(Locale local in supportedLang){
                    if(local.languageCode==currentLang.languageCode){
                      return currentLang;
                    }
                  }
                }
                return supportedLang.first;
              },
            );
          },
        ),
      ),
    );
  }
}