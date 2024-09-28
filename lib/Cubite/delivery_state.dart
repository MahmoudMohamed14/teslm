part of 'delivery_cubit.dart';

@immutable
sealed class DeliveryState {}

final class DeliveryInitial extends DeliveryState {}

class OtherPage extends DeliveryState{}

class ViewChange extends DeliveryState{}

class Reload extends DeliveryState{}

final class HomeInitial extends DeliveryState {}




