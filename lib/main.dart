import 'dart:convert';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/Utilities/FilesHandler/files_cubit.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/features/auth/controller/auth_cubit.dart';
import 'package:delivery/features/home/controller/home_cubit.dart';
import 'package:delivery/features/map_page/controller/map_cubit.dart';
import 'package:delivery/features/orders/controller/my_orders_cubit.dart';
import 'package:delivery/features/payment%20page/controller/order_cubit.dart';
import 'package:delivery/features/point/controller/point_cubit.dart';
import 'package:delivery/features/profile/navigator/chat/controller/chat_controller_cubit.dart';
import 'package:delivery/features/profile/navigator/my_account/controller/account_cubit.dart';
import 'package:delivery/features/profile/navigator/my_coupons/controller/coupons_cubit.dart';
import 'package:delivery/shared_preference/shared%20preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Cubite/them/app_dark_light_cubit.dart';
import 'Utilities/git_it.dart';
import 'Utilities/shared_preferences.dart';
import 'bloc_observer.dart';
import 'common/translate/app_local.dart';
import 'features/home/screens/home.dart';
import 'features/main_category_page/controller/category_cubit.dart';
import 'features/onboarding/screen/onboarding.dart';
import 'features/provider page/controller/provider_cubit.dart';
import 'features/splash/screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GitIt.initGitIt();
  DioHelper.init();
  await Save.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyBzyVkj9qekmoRKMOqRz1C0X506z82aXYc", // paste your api key here
      appId:
          "1:846687732996:android:7377921fed5088f96dfc51", //paste your app id here
      messagingSenderId: "1086097786847", //paste your messagingSenderId here
      projectId: "delivery-c021a", //paste your project id here
    ),
  );
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: "dmzdzq3ug");
  bool? onboard = Save.getdata(key: 'save');
  token = Save.getdata(key: 'token');
  print(token);
  print(customerId);
  Widget widget;
  if (onboard != null && onboard != false) {
    widget = const Home();
  } else {
    widget = const OnBoarding();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(Splash(home: widget)));
}

class MyApp extends StatefulWidget {
  const MyApp(this.start, {Key? key}) : super(key: key);
  final Widget start;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("initState>>>>>>>>>>>>>>>>>>> customerId=${Save.getdata(key: 'customerId')}}");
    print("   token ${SharedPref.getToken()}");
    //  String? json = Save.getdata(key: 'myCart');
    //  print('init after>>>>>>>>>>>>>>>>>>${jsonDecode(json??'') } ');
    //Save.remove(key: 'myCart');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      print('detached>>>>>>>>>>>>>>>');

      String? json = Save.getdata(key: 'myCart');
      print('after>>>>>>>>>>>>>>>>>>');

      if (json != null) {
        print('if>>>>>>>>>>>>>>>>>>');
        Save.remove(key: 'myCart');

        List<Map<String, dynamic>> cardList =
            (jsonDecode(json) as List<dynamic>)
                .map((item) => Map<String, dynamic>.from(item))
                .toList();

        // Use removeWhere to safely remove elements
        cardList.removeWhere((item) => item["isRestaurant"] == true);
        String encodedData = jsonEncode(cardList);
        print('Encoded data to save: $encodedData');
        try {
          bool onSave = await Save.savedata(key: 'myCart', value: encodedData);
          if (onSave) {
            print('done>>>>>>>>>>>>>>>>>>');
            print(" myCart=$cardList");
          }
        } catch (e) {
          print('Error saving data: $e');
        }
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('resumed>>>>>>>>>>>>>>>>>>');
      }
    }
    if (state == AppLifecycleState.inactive) {
      if (kDebugMode) {
        print('inactive>>>>>>>>>>>>>>');
      }
    }
    if (state == AppLifecycleState.paused) {
      if (kDebugMode) {
        print('paused>>>>>>>>>>>>>>>>>');
      }
    }
    if (state == AppLifecycleState.hidden) {
      if (kDebugMode) {
        print('hidden>>>>>>>>>>>>>>>>>');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DragFilesCubit>(
          create: (context) => DragFilesCubit(),
        ),
        BlocProvider<MyOrdersCubit>(
          create: (context) => MyOrdersCubit()..getCustomerOrders(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()
            ..offers()
            ..category()
            ..getProviderData(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit()..getNewCustomer(context),
        ),
        BlocProvider<MapCubit>(create: (context) => MapCubit()),
        BlocProvider<OrderCubit>(create: (context) => OrderCubit()),
        BlocProvider<AppDarkLightCubit>(
          create: (context) =>
              AppDarkLightCubit()..changeLang(fromCache: language ?? 'ar'),
        ),
        BlocProvider<ChatControllerCubit>(
          create: (context) => ChatControllerCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<CouponsCubit>(
          create: (context) => CouponsCubit(),
        ),
        BlocProvider<PointCubit>(
          create: (context) => PointCubit()
            ..getPointsAndBalance()
            ..getCouponsData(),
        ),
        BlocProvider<ProviderCubit>(
          create: (context) => ProviderCubit()..getCartList(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(),
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
              themeMode: isDark ?? false ? ThemeMode.dark : ThemeMode.light,
              home: widget.start,
              locale: Locale(AppDarkLightCubit.get(context).lang),
              localizationsDelegates: const [
                AppLocale.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar'), // Arabic
                Locale('en'), // English
              ],
              localeResolutionCallback: (currentLang, supportedLang) {
                if (currentLang != null) {
                  for (Locale local in supportedLang) {
                    if (local.languageCode == currentLang.languageCode) {
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
