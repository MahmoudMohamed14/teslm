part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class CouponLoading extends OrderState{}

class CouponSuccess extends OrderState{}

class CouponError extends OrderState{}

class PostOrderLoading extends OrderState{}

class PostOrderSuccess extends OrderState{}

class PostOrderError extends OrderState{}
