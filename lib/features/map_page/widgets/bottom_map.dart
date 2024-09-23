import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../Cubite/delivery_cubit.dart';
import '../../../common/components.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/provider model.dart';

Widget bottomMap(selectedLocationName,locationName,firstLatLng,secondLatLng,currentLocationMainPage,context)=>Container(
  height: 130,
  padding: const EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4.0,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on,
            size: 32.0,
            color: Colors.red,
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              selectedLocationName!=''?'$selectedLocationName':locationName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const Spacer(),
      bottom(language=='English Language'?'Confirm location':'تاكيد الموقع', ()async{
        var locations = await locationFromAddress(currentLocationMainPage);
        if (locations.isNotEmpty) {
          firstLatLng = locations.first.latitude;
          secondLatLng = locations.first.longitude;
        }
        DeliveryCubit.get(context).changeLocation(currentLocationMainPage,firstLatLng,secondLatLng);
        Navigator.pop(context);
        Navigator.pop(context);})
    ],
  ),
);