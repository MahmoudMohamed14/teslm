import 'dart:async';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/colors/theme_model.dart';
import '../../map_page/controller/map_cubit.dart';
import '../widgets/body_order_data.dart';

class OrderDetails extends StatelessWidget {
  final int orderIndex;
  const OrderDetails({super.key,required this.orderIndex});
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(MapCubit.get(context).position1??0, MapCubit.get(context).position2??0),
                zoom: 12.4746),),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20),
              child: InkWell(
                onTap: (){Navigator.pop(context);},
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: borderColor.shade300,
                  child:const Icon(
                    color: Colors.black,
                    size: 22,
                    Icons.arrow_back_ios_sharp,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 75.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(width:language=='en'? 140:100,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: ThemeModel.mainColor,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    CircleAvatar(radius: 13,backgroundColor: Colors.white,child: Icon(Icons.home,size: 25,color: ThemeModel.mainColor,),),
                    Text(language=='English Language'?'Apartment':'البيت',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                  ],),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 60.0),
                    child: CustomPaint(
                      size: Size(300, 550),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: MyDraggableSheet(orderIndex: orderIndex,child:const BottomSheetDummyUI(),)
          );
  }
}
class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const SizedBox(height: 10),
            seperate(),
            const SizedBox(height: 15),
          ],
        ));
  }
}
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
Future<void> openWhatsAppChat(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
