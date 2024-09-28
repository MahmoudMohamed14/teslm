import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:blured_navigation_bar_x/blured_navigation_bar_x.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/colors/theme_model.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/auth/screen/login.dart';
import 'package:delivery/features/home/controller/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../Cubite/them/app_dark_light_cubit.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../orders/screen/orders.dart';
import '../../point/screen/points.dart';
import '../../profile/screen/user_profile.dart';
import 'main_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
   /* List<BluredNavBarXItem> navBar = [
      BluredNavBarXItem(icon:  Icons.home,
        title: Strings.home.tr(context),
      ),
      BluredNavBarXItem(icon: Icons.apps_outlined,
        title: Strings.myOrders.tr(context),
      ),
      BluredNavBarXItem(icon: Icons.card_giftcard,
        title: Strings.points.tr(context),
      ),
      BluredNavBarXItem(icon: Icons.more_horiz,
        title: Strings.more.tr(context),
      ),
    ];*/
    List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon:SvgPicture.asset(ImagesApp.homeIcon,colorFilter:HomeCubit.get(context).current==0? ColorFilter.mode(ThemeModel.of(context).iconMainColor, BlendMode.srcIn):null,),
        label: Strings.home.tr(context),
      ),
      BottomNavigationBarItem(
        icon:SvgPicture.asset(ImagesApp.ordersIcon,colorFilter: HomeCubit.get(context).current==1?ColorFilter.mode(ThemeModel.of(context).iconMainColor, BlendMode.srcIn):null,),
        label: Strings.myOrders.tr(context),
      ),
      BottomNavigationBarItem(
        icon:SvgPicture.asset(ImagesApp.pointsIcon,colorFilter: HomeCubit.get(context).current==2?ColorFilter.mode(ThemeModel.of(context).iconMainColor, BlendMode.srcIn):null,),
        label: Strings.points.tr(context),
      ),
       BottomNavigationBarItem(
         icon:SvgPicture.asset(ImagesApp.moreIcon,colorFilter:HomeCubit.get(context).current==3? ColorFilter.mode(ThemeModel.of(context).iconMainColor, BlendMode.srcIn):null,),
        label:Strings.more.tr(context),
      ),
    ];
    return Scaffold(
        bottomNavigationBar:BlocConsumer<AppDarkLightCubit, AppDarkLightState>(
          builder:(context, state){
            return BottomNavigationBar(items: items
              ,onTap:
                  (index) {   HomeCubit.get(context).changeNavigator(index);
              pageController.jumpToPage(index);}
              ,unselectedLabelStyle:  TextStyle(color:  isDark??false?Colors.white:Colors.grey)
              ,selectedLabelStyle:  TextStyle(color:  ThemeModel.of(context).iconMainColor)
              ,type: BottomNavigationBarType.fixed
              ,currentIndex: HomeCubit.get(context).current,selectedItemColor: ThemeModel.of(context).iconMainColor
              ,unselectedItemColor: isDark??false?Colors.white:Colors.grey
              ,backgroundColor: ThemeModel.of(context).bottomNavigationBarColor,);
    },

          listener: (context, state) {}
        ),
       /* BluredNavigationBarX(
            browColor: ThemeModel.of(context).iconMainColor,
          backgroundColor: ThemeModel.of(context).bottomNavigationBarColor,
          selectedItemColor: ThemeModel.of(context).iconMainColor,
          unselectedItemColor:isDark??false?Colors.white:Colors.grey,
        currentIndex: HomeCubit.get(context).current,
        items:navBar,
          onPressed: (index) {   HomeCubit.get(context).changeNavigator(index);
          pageController.jumpToPage(index);
          },),*/
        body:PageView(
          controller: pageController,
          onPageChanged: (index) {
            HomeCubit.get(context).changeNavigator(index);
          },
          children: <Widget>
          [
            const MainPage(),
            token==''||token==null?const Login(fromOrder: true,):const Orders(),
            token=='' ||token==null?const Login():const Points(),
            const UserProfile(),
          ],
        )
    );
  },
);
  }
}
