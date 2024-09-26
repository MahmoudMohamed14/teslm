import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()){
  _getCurrentLocation();
  }

  static MapCubit get(context) => BlocProvider.of(context);

  String currentLocationName='';
  double ?position1;
  double ?position2;
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SystemNavigator.pop();
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;
      position1=position.latitude;
      position2=position.longitude;
      changeLocation(currentLocationName,position1,position2);
      currentLocationName = '${placemark.street??''},${placemark.locality}, ${placemark.country}';
    } catch (e) {
      SystemNavigator.pop();
    }
  }
  void changeLocation(newLocation,first,second){
    currentLocationName=newLocation;
    position1=first;
    position2=second;
    emit(Reload());
  }
}
