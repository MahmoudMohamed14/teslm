
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> getCurrentPosition(currentPosition,mapController,setState) async {
  try {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = position;
      _moveMapToCurrentPosition(currentPosition,mapController);
    });
  } catch (e) {
    print('Error getting location: $e');
  }
}
void _moveMapToCurrentPosition(currentPosition,mapController) {
  if (currentPosition != null ) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentPosition!.latitude,
            currentPosition!.longitude,
          ),
          zoom: 14.0,
        ),
      ),
    );
  }
}
