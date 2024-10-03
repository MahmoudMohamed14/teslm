import 'dart:async';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/features/map_page/controller/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import '../../../common/colors/theme_model.dart';
import '../../../common/images/images.dart';
import '../fuctions/map_functions.dart';

class Maps extends StatefulWidget {
  final String initialLocationName;
  final double firstPosition;
  final double secondPosition;
  // final LatLng initialLocationLatLng;
  Maps({required this.initialLocationName,required this.firstPosition,required this.secondPosition});
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final _yourGoogleAPIKey = 'AIzaSyCuYw0V7GTKhFC3N0H4UDwCh8wLkWaNIrI';
  late String _locationName ;
  String currentLocationMainPage='';
  Position? _currentPosition;
  late double firstLatLng;
  late double secondLatLng;
  String _selectedLocationName = '';
  late double firstPosition;
  late double secondPosition;
  Placemark ?_placemark;
  Timer? _debounceTimer;
  final _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GoogleMapController _mapController;
  Positioned? _centerIcon;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  void _initMapController() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _mapController = controller;
      _setCenterMarker();
    });
  }

  @override
  void initState() {
    _locationName = widget.initialLocationName;
    firstPosition = widget.firstPosition;
    secondPosition = widget.secondPosition;
    _initMapController();
    _getLatLngFromName(_locationName);
    super.initState();
  }

  Future<void> _getLatLngFromName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        setState(() {
          firstLatLng = locations.first.latitude;
          secondLatLng = locations.first.longitude;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void _debounce(VoidCallback callback, [Duration duration = const Duration(milliseconds: 500)]) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  void _onCameraMove(CameraPosition position) {
    _debounce(() {
      _getLocationName(position.target);
    });
  }
  Future<void> _getLocationName(LatLng latLng) async {
    try {
      await _fetchLocationData(latLng);
      _updateLocationName();
    } catch (e) {
      print('Error getting location name: $e');
    }
  }
  Future<void> _fetchLocationData(LatLng latLng) async {
    LatLngBounds visibleRegion = await _mapController.getVisibleRegion();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
    );
    if (placemarks.isNotEmpty) {
      _placemark = placemarks.first;
    }
  }

  void _updateLocationName() {
    String locationName = '${_placemark!.street ?? ''}, ${_placemark!.subLocality}, ${_placemark!.locality}, ${_placemark!.country}';
    currentLocationMainPage = '${_placemark!.street ?? ''}, ${_placemark!.locality}, ${_placemark!.country}';
    setState(() {
      _selectedLocationName = locationName;
    });
  }
  Future<void> _setCenterMarker() async {
    LatLngBounds visibleRegion = await _mapController.getVisibleRegion();
    LatLng centerPoint = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
    );

    setState(() {
      _centerIcon = Positioned(
        left: MediaQuery.of(context).size.width / 2 - 22,
        top: MediaQuery.of(context).size.height / 2 - 160,
        child: SvgPicture.asset(
          ImagesApp.pinMap,
          width: 40, // You can set width and height as needed
          height: 40,
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(language=='English Language'?'Order location':'موقع الطلب'),),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children:[ GoogleMap(zoomControlsEnabled:false,
                initialCameraPosition: CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(firstPosition,secondPosition),
                    tilt: 59.440717697143555,
                    zoom: 14.4746),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onCameraMove: _onCameraMove,
                onMapCreated: (GoogleMapController controller)async {
                  _mapController = controller;
                  _controller.complete(controller);
                } ),
                if (_centerIcon != null) _centerIcon!,
              Positioned(
                right: 10,
                left: 10,
                  top: 20,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: GooglePlacesAutoCompleteTextFormField(
                      textEditingController: _textController,
                      googleAPIKey: _yourGoogleAPIKey,
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
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
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
                           _mapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(latitude, longitude),
                                  zoom: 14.0,
                                ),
                              ),
                            );
                          FocusScope.of(context).unfocus();
                        }
                      },
                      itmClick: (Prediction prediction) => _textController.text = prediction.description!,
                    ),
                  ),),
              ],
            ),
          ),
          Container(
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
                        _selectedLocationName!=''?'$_selectedLocationName':_locationName,
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
                  BottomWidget(language=='English Language'?'Confirm location':'تاكيد الموقع', ()async{
                    List<Location> locations = await locationFromAddress(currentLocationMainPage);
                    if (locations.isNotEmpty) {
                        firstLatLng = locations.first.latitude;
                        secondLatLng = locations.first.longitude;
                    }
                      MapCubit.get(context).changeLocation(currentLocationMainPage,firstLatLng,secondLatLng);
                    Navigator.pop(context);
                    Navigator.pop(context);})
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 95.0),
        child: FloatingActionButton(
          backgroundColor: ThemeModel.mainColor,
          onPressed:()=> getCurrentPosition(_currentPosition,_mapController,setState),
           child: const Icon(Icons.gps_fixed,color: floatActionColor,),
            ),
      ));
  }

}
