import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../home/screens/home.dart';

Widget locationCard(context)=>Container(
  padding:const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: ThemeModel.of(context).cardsColor,
    borderRadius: BorderRadius.circular(10),),
  height: 270,
  child: Column(
    children: [
      Stack(
        children: [
          SizedBox(
            height: 170,
            child: GoogleMap(
              scrollGesturesEnabled:false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                  bearing: 193.8334901395799,
                  target: LatLng(DeliveryCubit.get(context).position1??0, DeliveryCubit.get(context).position2??0),
                  tilt: 59.440717697143555,
                  zoom: 14.4746),),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 22,
            top: 40,
            child: SvgPicture.asset(
              ImagesApp.pinMap,
              width: 30, // You can set width and height as needed
              height: 30,
            ),
          )
        ],
      ),
      SizedBox(height: 15,),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ThemeModel.of(context).bigCardBottomColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 25.0, ),
            const SizedBox(width: 10,),
            Flexible(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.orderLocation.tr(context),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                Text( DeliveryCubit.get(context).currentLocationName!=''?DeliveryCubit.get(context).currentLocationName:Strings.currentLocation.tr(context),maxLines: 1,
                  overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
              ],
            )),
            const SizedBox(width: 10,),
            bottom(Strings.change.tr(context), (){
              pageController=PageController(initialPage: 3);
              navigateAndFinish(context,const Home());},width: 90,radius: 30,height: 30,),
          ],),
      ),
    ],
  ),
);