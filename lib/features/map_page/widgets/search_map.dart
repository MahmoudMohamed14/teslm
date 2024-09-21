import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import '../../../common/colors/colors.dart';
import '../../../common/constant values.dart';
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

Widget searchMap(context,mapController,textController) {
  return Positioned(
  right: 10,
  left: 10,
  top: 20,
  child: Form(
    key: formKey,
    autovalidateMode: autoValidateMode,
    child: GooglePlacesAutoCompleteTextFormField(
      textEditingController: textController,
      googleAPIKey: 'AIzaSyCuYw0V7GTKhFC3N0H4UDwCh8wLkWaNIrI',
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15.7),
        ),
        hintText: language=='English Language'?'Enter order location':'اختار موقع الطلب',
        hintStyle:const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        fillColor: floatActionColor,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return language=='English Language'?'Please enter some text':'ادخل نص';
        }
        return null;
      },
      maxLines: 1,
      overlayContainer: (child) => Material(
        elevation: 1.0,
        color: floatActionColor,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
        getPlaceDetailWithLatLng: (prediction) {
          if (prediction.lat != null && prediction.lng != null) {
            double latitude = double.parse(prediction.lat!);
            double longitude = double.parse(prediction.lng!);
            print('Latitude: $latitude, Longitude: $longitude'); // Debugging
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 14.0,
                ),
              ),
            );
            FocusScope.of(context).unfocus();
          } else {
            print('No LatLng returned');
          }
        },
      itmClick: (Prediction prediction) => textController.text = prediction.description!,
    ),
  ),);
}