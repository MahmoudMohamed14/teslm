part of 'delivery_cubit.dart';

@immutable
sealed class DeliveryState {}

final class DeliveryInitial extends DeliveryState {}

class OtherPage extends DeliveryState{}

class ViewChange extends DeliveryState{}

class Reload extends DeliveryState{}

/*class SubmitValueEvent extends DeliveryState {
  final int value;
  SubmitValueEvent(this.value);
}*/

class ChangeLanguageSuccess extends DeliveryState{}

/*class GetProviderFoodLoading extends DeliveryState{}

class GetProviderFoodSuccess extends DeliveryState{}

class GetProviderFoodError extends DeliveryState{}*/

class GetOrdersLoading extends DeliveryState{}

class GetOrdersSuccess extends DeliveryState{}

class GetOrdersError extends DeliveryState{}

final class HomeInitial extends DeliveryState {}




