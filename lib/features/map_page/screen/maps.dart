import 'dart:async';
import 'package:delivery/common/colors/colors.dart';
import 'package:delivery/common/components.dart';
import 'package:delivery/common/translate/app_local.dart';
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
import '../../../common/translate/strings.dart';
import '../fuctions/map_functions.dart';

class Maps extends StatefulWidget {
  final String initialLocationName;
  final double firstPosition;
  final double secondPosition;
  // final LatLng initialLocationLatLng;
  const Maps({super.key, required this.initialLocationName,required this.firstPosition,required this.secondPosition});
  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
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
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: appBarWithIcons(Strings.orderLocation.tr(context),ImagesApp.locationAppBar,true,context),
      ),
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
                        hintText: Strings.enterOrderLocation.tr(context),
                        hintStyle:const TextStyle(color: Colors.black),
                        border:const OutlineInputBorder(),
                        fillColor: floatActionColor,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.enterTextSearch.tr(context);
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
              height: 140,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
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
                            Text(Strings.orderLocation.tr(context),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Text( _selectedLocationName!=''?_selectedLocationName:_locationName,maxLines: 1,
                              overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                          ],
                        )),
                        const SizedBox(width: 10,),
                      ],),
                  ),
                  BottomWidget(Strings.confirmLocation.tr(context), ()async{
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
