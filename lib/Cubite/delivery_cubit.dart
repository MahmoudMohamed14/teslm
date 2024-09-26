import 'dart:async';
import 'dart:convert';
import 'package:delivery/features/auth/controller/auth_cubit.dart';
import 'package:delivery/Dio/Dio.dart';
import 'package:delivery/common/constant/constant%20values.dart';
import 'package:delivery/models/categories%20provider.dart';
import 'package:delivery/models/otpModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../common/components.dart';
import '../models/customer orders model.dart';
import '../models/filter model.dart';
import '../models/provider items model.dart';
import '../shared_preference/shared preference.dart';
part 'delivery_state.dart';


class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial()){

    scrollControllerColumn.addListener(_onScroll);
    scrollControllerColumn.addListener(_scrollAnimation);
    if(providerFoodData!=null)
    _calculateListOffsets();
  }
  //============Resturant=================
  final ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  final ItemScrollController itemScrollController = ItemScrollController();
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
        if (opecity > 0.2) {
          opecity -= 0.2;
        } else {
          opecity = 0;
        }
      } else if (offset <= 20) {
        opecity = 1.0;
      } else {
        opecity = 0;
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
  void addValue(String name, int value,image,int foodPrice,id,description,extraId) {
    bool valueExists = false;
    for (var map in values) {
      if (map['name'] == name) {
        map['quantity'] = (map['quantity']! + 1);
        valueExists = true;
        break;
      }
    }
    if(!isRestaurant){
      for (var map in cardList) {
        if (map['name'] == name) {
          map['quantity'] = (map['quantity']! + 1);
          valueExists = true;
          break;
        }
      }
    }

    if (!valueExists) {
      values.add({
        'name': name,
        'quantity': value,
        'image': image,
        "categoryId":categoryId,
        'price': foodPrice,
        'itemId': id,
        'description':description,
        'selectedOptionGroups': extraId??[]
      });
      if(!isRestaurant) {
        cardList.add({
        'name': name,
        'quantity': value,
        'image': image,
        "categoryId":categoryId,
        'price': foodPrice,
        'itemId': id,
        'selectedOptionGroups': extraId??[]
      });
      }



      print(values);
    }
    getValueById('${id}');
    price+=foodPrice;
    emit(Reload());
    print(values);
    saveCardList();
  }
  bool isRestaurant=false;
  String ?categoryId;
  List<Map<String, dynamic>> cardList = [];
  double getPrice(){

    double total = 0.0;
   values.forEach((action){
    total+= action['price']! * action['quantity']!;
   });
    return total;

  }
  void saveCardList() {


   Save.savedata(key: 'myCart', value: jsonEncode(cardList)).then((onValue){
     if(onValue){
       getCartList();

     }
   });
  }
  void getCartList(){
    cardList=[];
    String? json = Save.getdata(key: 'myCart');
    if(json!=null){
      cardList =  (jsonDecode(json) as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
      print(" myCart=${cardList}");
    }
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
    if(!isRestaurant){
      for (var map in cardList) {
        if (map['name'] == name) {
          map['quantity'] = (map['quantity']! - 1);
          if (map['quantity'] == 0) {
            cardList.remove(map);
          }
          valueExists = true;
          break;
        }
      }
    }

    if (valueExists) {
      values = List.from(valuesCopy.reversed);
      price -= foodPrice;
      emit(Reload());
    }
    saveCardList();
  }
  void RemoveValue(index) {
      if (index >= 0 && index < values.length) {
        int productPrice = values[index]['price'].toInt();
        price -= productPrice;
       if(!isRestaurant) cardList.remove(values[index]);
        values.removeAt(index);

        emit(Reload());
      }
      saveCardList();
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

  /*void userInvitation(context){
    emit(LoginOTPLoading());
    DioHelper.postData(url: 'customers/generate-invitation-code', token: token, data: {}).then((value) {
      AuthCubit.get(context).loginOTP= LoginOTP.fromJson(value.data);
      print(value.data);
      token=AuthCubit.get(context).loginOTP!.token;
      emit(LoginOTPSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginOTPError());
    });
  }*/

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

