
import 'dart:convert';

import 'package:delivery/features/provider%20page/controller/provider_state.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../Dio/Dio.dart';
import '../../../common/components.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/provider items model.dart';
import '../../../shared_preference/shared preference.dart';
import 'package:collection/collection.dart';


class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(ProviderInitial()){
    scrollControllerColumn.addListener(_scrollAnimation);
  }

  static ProviderCubit get(context) => BlocProvider.of(context);
  void addValue(String name, int value,image,int foodPrice,id,description,extraId,providerId) {
    bool valueExists = false;
    int totalItems = 0;
    for (var map in values) {
      if (map['itemId'] == id) {
        print(" befor${map['quantity']}");
        map['quantity'] = (map['quantity']! + 1);
        totalItems = map['quantity']!;
        print(" after${map['quantity']}  $values;");
        valueExists = true;
        break;
      }
    }
    print(" herre  $values;");

    cardList.forEach((action){
      if (action['itemId'] == id) {
        action['quantity'] = totalItems;
        print(" after cardList${action!['quantity']}  $values;");


      }

    });


    if (!valueExists) {
      values.add({
        'name': name,
        'quantity': value,
        'image': image,
        "ProviderId":providerId,
        "isRestaurant":isRestaurant,
        'price': foodPrice,
        'itemId': id,
        'description':description,
        'selectedOptionGroups': extraId??[]
      });
      cardList.add({
        'name': name,
        'quantity': value,
        'image': image,
        "ProviderId":providerId,
        "isRestaurant":isRestaurant,
        'price': foodPrice,
        'itemId': id,
        'description':description,
        'selectedOptionGroups': extraId??[]
      });
      print(" inside add $values");


    }


    price+=foodPrice;
    emit(Reload());
    //print(values);
    saveCardList();
  }
  ProviderItemsMenu? providerFoodData;
  late AnimationController controller;
  void getProviderFoodData(id) {
    emit(GetProviderFoodLoading());
    DioHelper.getData(url: '${ApiEndPoint.providers}/$id',)
        .then((value) {
      providerFoodData=ProviderItemsMenu.fromJson(value.data);
      print(value.data);
      emit(GetProviderFoodSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetProviderFoodError());
    });
  }
  int itemsNumber = 1;
  bool isRestaurant=false;
  String ?categoryId;
  List<Map<String, dynamic>> cardList = [];
  double getPrice(){

    double total = 0.0;
    values.forEach((item){
      if(item['selectedOptionGroups']?.isNotEmpty??false){
        print('here');
        total+= item['price']! * item['quantity']!;
        item['selectedOptionGroups'][0]['selectedOption']?.forEach((value){
          total+= value['price']! * item['quantity']!;
        });
      }else{
        total+= item['price']! * item['quantity']!;
      }
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
   // List<Map<String, dynamic>> valuesCopy = List.from(values.reversed);

    for (var map in values) {

      if (map['itemId'] == id) {

        map['quantity'] = (map['quantity']! - 1);
        if (map['quantity'] == 0) {
          values.remove(map);
        }
        valueExists = true;
        break;
      }
    }

      for (var map in cardList) {
        if (map['itemId'] == id) {

          map['quantity'] = (map['quantity']! - 1);
          if (map['quantity'] == 0) {
            cardList.remove(map);
          }
          valueExists = true;
          break;
        }

    }

    if (valueExists) {
     // values = List.from(valuesCopy.reversed);
      price -= foodPrice;
      emit(Reload());
    }
    saveCardList();
    emit(Reload());

  }
  void RemoveValue(index) {
    if (index >= 0 && index < values.length) {
      int productPrice = values[index]['price'].toInt();
      price -= productPrice;
       cardList.remove(values[index]);
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
   // /* return values.fold(0, (int total, Map<String, dynamic> item) {
   //    if (item['itemId'] == itemId) {
   //      return total + item['quantity'] as int;
   //    }
   //    return total;
   //  });*/
    return values.firstWhereOrNull((item) => item['itemId'].toString() == itemId)?['quantity']??0;
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
  void submitValue(value) {
    emit(SubmitValueEvent(value));
  }
  List<Map<String, dynamic>>  addExtra=[];
  void addIdToSelectedOption(List<OptionGroups> optionsGroups,List<List<bool>> checklist) {
    bool valueExists = false;
    for(int i=0;i<optionsGroups.length;i++){
      for(int j=0;j<(optionsGroups[i].options?.length??0);j++){
       if(checklist[i][j]==true){
         for (var group in addExtra) {
           if (group["id"] == "${optionsGroups[i].id}") {
             valueExists=true;
             group["selectedOption"].add({
               "id": optionsGroups[i].options?[j].id,
               "price": optionsGroups[i].options?[j].price
             });
             break;
           }
         }
         if(!valueExists){
           addExtra.add({
             "id":optionsGroups[i].id,
             "selectedOption": [
               {
                 "id": optionsGroups[i].options?[j].id,
                 "price": optionsGroups[i].options?[j].price
               }
             ]
           });
         }
       }



      }

    }




  }
  bool showSearchProvider=false;
  void showSearch(){
    showSearchProvider= true;
    print(showSearchProvider);
    emit(Reload());

  }
  void hideSearch(){
    showSearchProvider= false;
    print(showSearchProvider);
    emit(Reload());
  }
  List<Items>allItems=[];
  List<Items>searchedItems=[];
  final RegExp english = RegExp(r'^[a-zA-Z]+');
  bool langEn=true;
  void changeLang(String text){
    if (english.hasMatch(text)) {
      langEn = true;
    } else {
      langEn = false;
    }
  }
  void searchProvider(String name){

    changeLang(name);
   allItems=[];
   searchedItems=[];
   if(name.isNotEmpty) {
     providerFoodData?.CategoriesItemsData?.forEach((element) {
       element.items?.forEach((element1) {
         allItems.add(element1);
       });
     });
     searchedItems = allItems.where((element) =>
     (langEn ? element.name?.en?.toLowerCase().contains(name.toLowerCase()) ??
         false : element.name?.ar?.toLowerCase().contains(name.toLowerCase()) ??
         false) ||
         (langEn ? element.description?.en?.toLowerCase().contains(
             name.toLowerCase()) ?? false : element.description?.ar
             ?.toLowerCase().contains(name.toLowerCase()) ?? false) ||
         (element.price.toString().contains(name))
     ).toList();
     print('Search: $searchedItems');
     print(searchedItems.lastOrNull?.name?.en??''+"SEARCH HERE"+"${searchedItems.firstOrNull?.price}");
   }

    emit(Reload());
  }
  double opecity=1;
  final ItemScrollController itemScrollController = ItemScrollController();
  double expandedHeight = 80.0;
   ScrollController scrollControllerColumn = ScrollController();
  ScrollController get scrollController => scrollControllerColumn;
  _scrollAnimation(){
    final double offset = scrollControllerColumn.offset;
    if (offset > 20 && offset < 50) {
      if (expandedHeight > 30) {
        expandedHeight -= offset * 0.1;
      }
      if (opecity > 0.2) {
        opecity -= 0.2;
      } else {
        opecity = 0;
      }
    }
    else if (offset <= 20) {
      opecity = 1.0;
      expandedHeight = 80.0;
    } else {
      opecity = 0;
      expandedHeight = 30;
    }
    emit(Reload());
  }


 /* void scrollToIndex(int index) {
    int items = calculateItemsBeforeIndex(index);
    scrollController.animateTo(
      items * 150, // Replace ITEM_HEIGHT with the height of each item in your list
      duration: Duration(milliseconds: 500), // Adjust the duration as per your preference
      curve: Curves.easeOut, // Adjust the curve as per your preference
    );
    emit(Reload());
  }*/

}
