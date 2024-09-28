part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class OrderInitial extends MyOrdersState {}

class GetOrdersLoading extends MyOrdersState{}

class GetOrdersSuccess extends MyOrdersState{}

class GetOrdersError extends MyOrdersState{}
