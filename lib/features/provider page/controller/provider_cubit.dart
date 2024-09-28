
import 'dart:convert';

import 'package:delivery/features/provider%20page/controller/provider_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Dio/Dio.dart';
import '../../../common/components.dart';
import '../../../common/end_points_api/api_end_points.dart';
import '../../../common/constant/constant values.dart';
import '../../../models/provider items model.dart';
import '../../../shared_preference/shared preference.dart';


class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(ProviderInitial());
  static ProviderCubit get(context) => BlocProvider.of(context);
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
  ProviderItemsMenu? providerFoodData;
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
    print("هي");
    bool valueExists = false;
   // List<Map<String, dynamic>> valuesCopy = List.from(values.reversed);

    for (var map in values) {
      print("before1 = ${map}");
      if (map['itemId'] == id) {
        print("before = ${map}") ;
        map['quantity'] = (map['quantity']! - 1);
        if (map['quantity'] == 0) {
          values.remove(map);
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
     // values = List.from(valuesCopy.reversed);
      price -= foodPrice;
      emit(Reload());
    }
    emit(Reload());
    if(!isRestaurant) saveCardList();
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
  void addIdToSelectedOption(optionGroupId,optionId,int price) {
    bool valueExists = false;
    for (var group in addExtra) {
      if (group["id"] == "$optionGroupId") {
        valueExists=true;
        group["selectedOption"].add({
          "id": optionId,
          "price": price
        });
        break;
      }
    }
    if(!valueExists){
      addExtra.add({
        "id": optionGroupId,
        "selectedOption": [
          {
            "id": optionId,
            "price": price
          }
        ]
      });
    }
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
