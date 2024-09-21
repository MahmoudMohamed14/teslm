import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/common/constant%20values.dart';
import 'package:delivery/common/extensions.dart';
import 'package:delivery/common/images/images.dart';
import 'package:delivery/common/translate/applocal.dart';
import 'package:delivery/models/categories%20provider.dart';
import 'package:delivery/models/chat%20model.dart';
import 'package:delivery/models/coupon%20model.dart';
import 'package:delivery/models/get%20user%20data.dart';
import 'package:delivery/models/login%20model.dart';
import 'package:delivery/models/offers model.dart';
import 'package:delivery/models/otpModel.dart';
import 'package:delivery/shared%20prefernace/shared%20preferance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../common/colors/theme_model.dart';
import '../common/components.dart';
import '../common/text_style_helper.dart';
import '../common/translate/strings.dart';
import '../features/auth/screen/otp number.dart';
import '../features/home/screens/home.dart';
import '../features/payment page/screen/payment.dart';
import '../models/Categories model.dart';
import '../models/customer orders model.dart';
import '../models/filter model.dart';
import '../models/get coupons model.dart';
import '../models/provider items model.dart';
import '../models/provider model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../widgets/app_text_widget.dart';
part 'delivery_state.dart';


class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial()){
    _getCurrentLocation();
    scrollControllerColumn.addListener(_onScroll);
    scrollControllerColumn.addListener(_scrollAnimation);
    if(providerFoodData!=null)
    _calculateListOffsets();
  }
  int current = 3;
  int advertising = 0;
  bool changeViewNew=false;
  String currentLocationName='';
  double ?position1;
  double ?position2;
  //============Resturant=================
  final ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  final ItemScrollController itemScrollController = ItemScrollController();
  double expandedHeight = 345.0;
  double imageHeight=200.0;
  double containerHeight=180.0;
  double containerPadding = 100.0;
  double rowItems=150;
  double opecity=1;
  int currentIndex = 0;
  //======================================
  static DeliveryCubit get(context) => BlocProvider.of(context);
  void increment(){
    emit(Reload());
  }
  //===============resturant=============
  _scrollAnimation(){
    final double offset = scrollControllerColumn.offset;
      if (offset > 20 && offset < 50) {
        imageHeight = 200 - offset;
        containerPadding = 100 - offset * 0.0002;
        containerHeight = 180 - offset * 2.5;
        if (expandedHeight > 150) {
          expandedHeight -= offset * 0.1;
        }
        rowItems = 150 - offset;
        if (opecity > 0.2) {
          opecity -= 0.2;
        } else {
          opecity = 0;
        }
      } else if (offset <= 20) {
        imageHeight = 200 - offset * 0.002;
        containerPadding = 100.0;
        containerHeight = 180 - offset * 1.9;
        rowItems = 150.0;
        opecity = 1.0;
        expandedHeight = 345.0;
      } else {
        opecity = 0;
        expandedHeight = 150;
        containerHeight = 64;
      }
    emit(Reload());
  }
  List<int> listOffsets = [];
  void _calculateListOffsets() {
    int offset = 0;
    for (int i = 0; i < providerFoodData!.CategoriesItemsData!.length; i++) {
      listOffsets.add(offset);
      offset += providerFoodData!.CategoriesItemsData![i].items!.length * 140;
    }
  }

  void _onScroll() {
    final itemHeight = 150; // Replace with the actual height of each item
    final offset = scrollControllerColumn.offset;
    int? currentIndexNew;

    _calculateListOffsets(); // Call _calculateListOffsets() before using listOffsets

    if (listOffsets.isNotEmpty) {
      for (int i = 0; i < listOffsets.length; i++) {
        final startOffset = listOffsets[i];
        final endOffset = startOffset + providerFoodData!.CategoriesItemsData![i].items!.length * itemHeight;

        if (offset >= startOffset && offset < endOffset) {
          currentIndexNew = i;
          break;
        }
      }
      // Check if the scrollControllerColumn is at the last page
      final totalHeight = listOffsets.last + providerFoodData!.CategoriesItemsData![listOffsets.length - 1].items!.length * itemHeight;
      if (scrollControllerColumn.position.pixels >= totalHeight - scrollControllerColumn.position.viewportDimension) {
        currentIndexNew = providerFoodData!.CategoriesItemsData!.length; // Set currentIndexNew to 4 if the scrollControllerColumn is at the last page
      }
      if (currentIndexNew != currentIndex) {
        currentIndex = currentIndexNew!;
          Timer(Duration(milliseconds: 200), () {
            itemScrollController.jumpTo(index: currentIndex, alignment:currentIndex==0||currentIndex==1? 0.0:0.3);
          });
      }
    }
    emit(Reload());
  }

  int calculateItemsBeforeIndex(int foodIndex) {
    int totalItems = 0;
    if (providerFoodData!.CategoriesItemsData!.isNotEmpty && foodIndex >= 0 && foodIndex < providerFoodData!.CategoriesItemsData!.length) {
      for (int i = 0; i < foodIndex; i++) {
        totalItems += providerFoodData!.CategoriesItemsData![i].items!.length;
      }
    }
    return totalItems;
  }

  void scrollToIndex(int index) {
    int items = calculateItemsBeforeIndex(index);
    scrollController.animateTo(
      items * 150, // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeOut, // Adjust the curve as per your preference
    );
    emit(Reload());
  }
  void addValue(String name, int value,image,int foodPrice,id,extraId) {
    bool valueExists = false;
    for (var map in values) {
      if (map['name'] == name) {
        map['quantity'] = (map['quantity']! + 1);
        valueExists = true;
        break;
      }
    }
    if (!valueExists) {
      values.add({
        'name': name,
        'quantity': value,
        'image': image,
        'price': foodPrice,
        'itemId': id,
        'selectedOptionGroups': extraId??[]
      });
      print(values);
    }
    getValueById('${id}');
    price+=foodPrice;
    emit(Reload());
    print(values);
  }

  void minusValue(String name, int value, image, int foodPrice, id) {
    bool valueExists = false;
    List<Map<String, dynamic>> valuesCopy = List.from(values.reversed);

    for (var map in valuesCopy) {
      if (map['name'] == name) {
        map['quantity'] = (map['quantity']! - 1);
        if (map['quantity'] == 0) {
          valuesCopy.remove(map);
        }
        valueExists = true;
        break;
      }
    }

    if (valueExists) {
      values = List.from(valuesCopy.reversed);
      price -= foodPrice;
      emit(Reload());
    }
  }
  void RemoveValue(index) {
      if (index >= 0 && index < values.length) {
        int productPrice = values[index]['price'].toInt();
        price -= productPrice;
        values.removeAt(index);
        emit(Reload());
      }
  }
  bool isNameInList(String name) {
    for (var map in values) {
      if (map['name'] == name) {
        return true;
      }
    }
    return false;
  }

  int getValueById(String itemId) {
    return values.fold(0, (int total, Map<String, dynamic> item) {
      if (item['itemId'] == itemId) {
        return total + item['quantity'] as int;
      }
      return total;
    });
  }
  //==============
  LoginUser ?loginUser;
  void userLogin({
    required String phoneNumber,
    required String code,
    required BuildContext context,
  }){
    emit(LoginLoading());
    DioHelper.postData(url: 'customers/generate-otp', data: {
      'phoneNumber' : "$code${phoneNumber}",
    }).then((value) {
      loginUser= LoginUser.fromJson(value.data);
      navigate(context, OtpNumber(phoneNumber: phoneNumber, country: code,));
      emit(LoginSuccess());
      print("Done ${phoneNumber}");
    }).catchError((error) {
      print('error=============');
      emit(LoginError(error.toString()));
    });
  }
  LoginOTP ?loginOTP;
  void userLoginOTP({
    required String phoneNumber,
    required String otp,
    required context
  }){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/verify-otp', data: {
      'otp':otp,
      'phoneNumber' : phoneNumber,
    }).then((value)
    async{

      print("Succussfull");
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      changeNavigator(3);
      customerId=loginOTP!.id;
      Save.savedata(key: 'customerId',value:loginOTP!.id).then((value){
        getPointsCustomer();
        getCouponsData();
        getPointsAndBalance();
      }) ;
      Save.savedata(key: 'token', value: token).then((value){
        loginFromCart? navigate(context, Payment(customerNotes: '')): navigateAndFinish(context,const Home());
      });
      getCustomerOrders();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Align(
            alignment: Alignment.center,
            child: Text(language=='English Language'?"Login successfully":'تم تسجيل الدخول بنجاح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(LoginOTPSuccess());
    }).catchError((error) {
      if(otp.length==6){
        showDialogHelper(context,contentWidget: 
        Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset(ImagesApp.messageCode,fit: BoxFit.cover,height: 120.h,width: 130.w,),
            16.h.heightBox,
            AppTextWidget( Strings.codeYouEnteredInvalid.tr(context),style: TextStyleHelper.of(context).regular14,),
            5.h.heightBox,
            Center(child: AppTextWidget( Strings.resendCode.tr(context)
                ,style: TextStyleHelper.of(context).regular14.copyWith(color: ThemeModel.of(context).primary,fontWeight: FontWeight.w900))),
            
          ],
        ),);
      }
      print('eeeeeeeeeeeeeeeeeeeeee ${error.toString()}');
      emit(LoginOTPError());
    });
  }
  //======================================================
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
      print(e);
    }
  }
  void changeLocation(newLocation,first,second){
    currentLocationName=newLocation;
    position1=first;
    position2=second;
    emit(Reload());
  }
  void changeNavigator(int index) {
    current = index;
    emit(Reload());
  }
  void changeAdds(int index) {
    advertising = index;
    emit(OtherPage());
  }
  void changeView() {
    changeViewNew = !changeViewNew;
    emit(CategoryProviderSuccess());
  }
  Advertising? offersData;
  void offers(){
    emit(OffersLoading());
    DioHelper.getData(url: 'ads',
      myapp: true,
    ).then((value) {
      offersData=Advertising.fromJson(value.data);
      print(value.data);
      emit(OffersSuccess());
    }).catchError((error) {
      print('eeeeeeeeeeeeeeeeeeeeeeeee ${error.toString()}');
      emit(OffersError());
    });
  }
  void submitValue(value) {
    emit(SubmitValueEvent(value));
  }

  List<bool> isCheckedList =[ true,false,false];
  bool choosePadding =true;

  void changePaymentMethod(index){
    if(index==1){isCheckedList=[false,true,false];emit(Reload());}
    else if(index==2){isCheckedList=[false,false,true];emit(Reload());}
    else {isCheckedList=[true,false,false];emit(Reload());}
    choosePadding =false;
  Timer(Duration(milliseconds: 350), () {
    choosePadding = true;
    emit(Reload());
  });
}
  List<Categories> ?categoryData;
  void category() {
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories', myapp: true)
        .then((value) {
      final List<dynamic> categories = value.data;
      categoryData = categories.map((item) => Categories.fromJson(item)).toList();
      print('trrrrrrrrrrrrrrrr');
      emit(CategoriesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesError());
    });
  }

  FilterProviders? filterProvideData;
  void filterProvider({id,sortField,sortBy}) {
    emit(FilterProviderLoading());
    DioHelper.getData(url: 'providers/customers?sortOrder=$sortField&sortField=$sortBy', myapp: true)
        .then((value) {
      filterProvideData = FilterProviders.fromJson(value.data);
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print('providers/customers?sortOrder=DESC&sortField=$sortBy');
      print(error.toString());
      emit(FilterProviderError());
    });
  }
  CategoryProviderModel? categoryProvideData;
  void categoryProvider({id}) {
    emit(CategoryProviderLoading());
    DioHelper.getData(url: 'categories/$id', myapp: true)
        .then((value) {
      categoryProvideData = CategoryProviderModel.fromJson(value.data);
      emit(CategoryProviderSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryProviderError());
    });
  }
//=====================Login==================================
  String generatedOtp = '';

  // Generate OTP
  void generateOtp({int length = 6}) {
    final random = Random();
    generatedOtp = '';
    for (int i = 0; i < length; i++) {
      generatedOtp += random.nextInt(10).toString(); // Generates random digit
    }
    emit(OtpInitial());
  }
  Future<void> addSender(String username, String apiKey, String senderName, String userFile) async {
    final url = Uri.parse('https://www.msegat.com/gw/addSender.php');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'userName': username,
      'apiKey': apiKey,
      'senderName': senderName,
      'senderType': 'normal', // or 'whitelist'
      'userFile': userFile,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        inquireSenders(username, apiKey);
        print('Sender ID added successfully: ${responseBody['response_message']}');
      } else {
        print('Failed to add sender ID. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding sender ID: $e');
    }
  }
  Future<void> inquireSenders(String username, String apiKey) async {
    final url = Uri.parse('https://www.msegat.com/gw/senders.php');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'userName': username,
      'apiKey': apiKey,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Sender IDs: ${responseBody['response_message']}');
      } else {
        print('Failed to inquire sender IDs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error inquiring sender IDs: $e');
    }
  }
  Future<void> sendOtpMessage(String username, String apiKey, String recipient, String language, String senderId) async {
    emit(OtpSending());

    final url = Uri.parse('https://www.msegat.com/gw/sendOTPCode.php');
    final headers = {
      'Content-Type': 'application/json',
      'lang': language, // Ensure the language is correctly set (e.g., 'Ar' or 'En')
    };

    final body = jsonEncode({
      'userName': username,
      'apiKey': apiKey,
      'number': recipient, // Ensure recipient is in international format without leading zeros
      'userSender': senderId, // Use the registered sender ID here
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['code'] == 1) {
          final id = responseBody['id']; // Store the ID for verification
          emit(OtpSentSuccess());
          return id; // Return the ID for verification
        } else {
          final errorMessage = responseBody['message'] ?? 'Unknown error';
          emit(OtpSentFailure('Failed to send OTP. Message: $errorMessage'));
        }
      } else {
        emit(OtpSentFailure('Failed to send OTP. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(OtpSentFailure('Error sending OTP: $e'));
    }
  }
  Future<void> verifyOtpCode(String username, String apiKey, String code, String id, String userSender, String language) async {
    emit(OtpVerifying());

    final url = Uri.parse('https://www.msegat.com/gw/verifyOTPCode.php');
    final headers = {
      'Content-Type': 'application/json',
      'lang': language, // Add language to the headers
    };

    final body = jsonEncode({
      'userName': username,
      'apiKey': apiKey,
      'code': code,
      'id': id, // Use the id from the send OTP response
      'userSender': userSender,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['code'] == 1) {
          OtpVerifySuccess();
        } else {
          emit(OtpVerifyFailure('Invalid OTP'));
        }
      } else {
        emit(OtpVerifyFailure('Invalid OTP'));
      }
    } catch (e) {
      emit(OtpVerifyFailure('Invalid OTP'));
    }
  }
  //=====================Login==================================



  void changeLanguage(language){
    language = language;
    emit(ChangeLanguageSuccess());
  }
  Points ?balanceAndPointsData;
  void getPointsAndBalance(){
    emit(GetPointsLoading());
    DioHelper.getData(url: 'wallet/$customerId',myapp: true).then((newValue) async {
      balanceAndPointsData=Points.fromJson(newValue.data);
      balances=await Save.savedata(key: 'balance',value:balanceAndPointsData!.balance);
      print(newValue.data);
      emit(GetPointsSuccess());
    }).catchError((error){
      emit(GetPointsError());
    });
  }

  GetCoupons ?couponsData;
  void getCouponsData(){
    emit(GetCouponsLoading());
    DioHelper.getData(url: 'coupons',myapp: true,query: {
      "customerId":"$customerId"
    }).then((value) async {
      couponsData=GetCoupons.fromJson(value.data);
      print(value.data);
      emit(GetCouponsSuccess());
    }).catchError((error){
      emit(GetCouponsError());
    });
  }

  void redeemPointsCustomer(context){
    emit(RedeemPointsLoading());
    DioHelper.postData(url: 'wallet/$customerId/redeem-points',).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(language=='English Language'?'Your points has been redeemed successfully':"تم استبدال نقاطك بنجتح",style:TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      getPointsAndBalance();
      getCouponsData();
      emit(RedeemPointsSuccess());
    }).catchError((error) {
      print(error.toString());
      if(balanceAndPointsData!.points!<10000){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Your points less than 10,000":'نقاطك اقل من 10,000',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));}else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade400,
          content:  Align(
              alignment: Alignment.center,child: Text(language=='English Language'?"Failed to redeem your points":'فشلت عملية استبدال نقاطك',style: TextStyle(color: Colors.white,fontSize: 17),)),
        ));
      }
      emit(RedeemPointsError());
    });
  }
  void getPointsCustomer(){
    emit(GetUserLoading());
    DioHelper.getData(url: 'coupons/$customerId',
        token: token,
        myapp: true
    ).then((value) async{
      emit(GetUserSuccess());
      print(value.data);
    }).catchError((error) {
      emit(GetUserError());
    });
  }
  GetUserData ?getUserData;
  void getNewCustomer(){
    emit(GetUserLoading());
    DioHelper.getData(url: 'customers/auth/me',
      token: token,
    myapp: true
    ).then((value) async{
      getUserData=GetUserData.fromJson(value.data);
      getPointsAndBalance();
      getCouponsData();
      emit(GetUserSuccess());
    }).catchError((error) {
      emit(GetUserError());
    });
  }
  void userInvitation(){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/generate-invitation-code', token: token, data: {}).then((value) {
      loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=loginOTP!.token;
      emit(LoginOTPSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginOTPError());
    });
  }
  void userUpdate({
    String ?username ,
    String ?email ,
    String ?birthdate ,
    context
  }){
    emit(UpdateUserLoading());
    Map<String, dynamic> data = {}; // Create an empty map to hold the updated data
    if (username != null) {data['name'] = username;}
    if (email != null) {data['email'] = email;}
    if (birthdate != null) {data['birthdate'] = birthdate;
    }
    print(data);
    DioHelper.patchData(url: 'customers/auth/me',token: token,data:data).then((value) {
      DioHelper.getData(url: 'customers/auth/me',
          token: token,
          myapp: true
      ).then((value) {
        getUserData=GetUserData.fromJson(value.data);
        print(value.data);
      });
      print(data);
      emit(UpdateUserSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserError());
    });
  }
  Provider? providerData;
  void getProviderData(){
    emit(GetProviderLoading());
    DioHelper.getData(url:'providers/customers',
        myapp: true
    ).then((value) {
      providerData = Provider.fromJson(value.data);
      print('truuuuuuuuuuuuuuuuuuuuuu');
        emit(GetProviderSuccess());
      }).catchError((error) {
        print('eeeeeeeeeeeeeeeeeeeeeeee ${error.toString()}');
      emit(GetProviderError());
    });
  }
  ProviderItemsMenu? providerFoodData;
  void getProviderFoodData(id) {
    emit(GetProviderFoodLoading());
    DioHelper.getData(url: 'providers/$id', myapp: true,)
        .then((value) {
      providerFoodData=ProviderItemsMenu.fromJson(value.data);
      print(value.data);
      emit(GetProviderFoodSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetProviderFoodError());
    });
  }
  Coupon ?couponData;
  void postCoupon({
    required String coupon,
    required int subtotal,
    required int shippingPrice,
    context
  }){
    emit(CouponLoading());
    DioHelper.postData(url: 'coupons/validate', data: {
      'code' : coupon,
      'subtotal':subtotal,
      'shippingPrice':shippingPrice
    }).then((value) {
      couponData=Coupon.fromJson(value.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Coupon add successfully":'تم اضافه الكوبون بنجاح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      Navigator.pop(context);
      emit(CouponSuccess());
    }).catchError((error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Coupon is not valid":'الكوبون ليس صحيح',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      Navigator.pop(context);
      emit(CouponError());
    });
  }
  void postOrder({
    String? coupon,
    required List items,
    required String customerId,
    required String deliveryPartnerId,
    required String customerNotes,
    context
  }){
    emit(PostOrderLoading());
    var postdata={
      "items": items,
      "deliveryPartnerId": "07cfd32e-7a27-468a-96ea-f527c9cbc496",
      "customerId": customerId,
      "customerNotes": customerNotes
    };
    print(postdata);
    DioHelper.postData(url: 'orders', data:postdata).then((value) {
      pageController=PageController(initialPage: 2);
      DeliveryCubit.get(context).changeNavigator(2);
      getPointsAndBalance();
      getCustomerOrders();
      DeliveryCubit.get(context).couponData=null;
      navigateAndFinish(context, Home());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Align(
          alignment: Alignment.center,child: Text(language=='English Language'?'Order has been done successfully':"تم تنفيذ الطلب بنجتح",style:TextStyle(fontSize: 17,color: Colors.white) ,)),backgroundColor: Colors.green.shade400,),);
      emit(PostOrderSuccess());
    }).catchError((error) {
      print('Error message: ${error.response?.data['message']}');
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade400,
        content:  Align(
            alignment: Alignment.center,child: Text(language=='English Language'?"Failed to execute the order":'فشل تنفيذ الاوردر',style: TextStyle(color: Colors.white,fontSize: 17),)),
      ));
      emit(PostOrderError());
    });
  }
  CustomerOrders? customerOrders;
  void getCustomerOrders(){
    emit(GetOrdersLoading());
    DioHelper.getData(url: 'orders/customer',
      token: token,
      myapp: true,
    ).then((value) {
      customerOrders=CustomerOrders.fromJson(value.data);
      print(value.data);
      emit(GetOrdersSuccess());
    }).catchError((error) {
      print('tttttttttttttttttttttt ${error.toString()}');
      emit(GetOrdersError());
    });
  }
}

