import 'package:delivery/common/translate/app_local.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Cubite/delivery_cubit.dart';
import '../../../common/colors/colors.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../common/images/images.dart';
import '../../../common/translate/strings.dart';
import '../../home/screens/home.dart';

Widget locationCard(context)=>Container(
  padding:const EdgeInsets.all(10),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 0.9,color: borderColor)),
  height: 250,
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
                  bearing: 192.8334901395799,
                  target: LatLng(DeliveryCubit.get(context).position1??0, DeliveryCubit.get(context).position2??0),
                  tilt: 59.440717697143555,
                  zoom: 14.4746),),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 22,
            top: 40,
            child: Image.asset(
              ImagesApp.pinMap,
              width: 48,
              height: 40,
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            size: 25.0, color: Colors.red,),
          const SizedBox(width: 10,),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.orderLocation.tr(context),style: TextStyle(color: isDark??false ?floatActionColor:brownColor,fontSize: 17),),
              Text( DeliveryCubit.get(context).currentLocationName!=''?DeliveryCubit.get(context).currentLocationName:language=='English Language'?'Current Location':'عنوانك الحالى',maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color:isDark??false? floatActionColor:brownColor.shade300),),
            ],
          )),
          const SizedBox(width: 10,),
          InkWell(
            onTap: (){
              pageController=PageController(initialPage: 3);
              navigateAndFinish(context,const Home());},
            child: Container(
              decoration: BoxDecoration( color: Colors.grey.shade300, borderRadius: BorderRadius.circular(6)),
              padding:const EdgeInsets.all(5),
              child: Text(Strings.change.tr(context),style:const TextStyle(color: brownColor,fontSize: 17,),),),
          )
        ],),
    ],
  ),
);