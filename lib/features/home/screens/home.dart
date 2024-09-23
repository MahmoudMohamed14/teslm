import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:blured_navigation_bar_x/blured_navigation_bar_x.dart';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/common/translate/app_local.dart';
import 'package:delivery/features/auth/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/translate/strings.dart';
import '../../orders/screen/orders.dart';
import '../../point/screen/points.dart';
import '../../profile/screen/user_profile.dart';
import 'main_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    List<BluredNavBarXItem> navBar = [
      BluredNavBarXItem(icon: Icons.more_horiz,
        title: Strings.more.tr(context),
      ),
      BluredNavBarXItem(icon: Icons.card_giftcard,
        title: Strings.points.tr(context),
      ),
      BluredNavBarXItem(icon: Icons.apps_outlined,
        title: Strings.myOrders.tr(context),
      ),
      BluredNavBarXItem(icon:  Icons.home,
        title: Strings.home.tr(context),
      ),
    ];
    return Scaffold(
        bottomNavigationBar:BluredNavigationBarX(
            browColor: ColorsApp.iconsMainColor,
          backgroundColor: isDark??false? ColorsApp.bottomNavigationBarColor:Colors.white,
          selectedItemColor: ColorsApp.iconsMainColor,
          unselectedItemColor:isDark??false?Colors.white:Colors.grey,
        currentIndex: DeliveryCubit.get(context).current,
        items:navBar,
          onPressed: (index) {   DeliveryCubit.get(context).changeNavigator(index);
          pageController.jumpToPage(index);},),
        body:PageView(
          controller: pageController,
          onPageChanged: (index) {
            DeliveryCubit.get(context).changeNavigator(index);
          },
          children: <Widget>
          [
            const UserProfile(),
            token=='' ||token==null?const Login():const Points(),
            token==''||token==null?const Login(fromOrder: true,):const Orders(),
            const MainPage(),
          ],
        )
    );
  },
);
  }
}
