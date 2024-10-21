part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class CouponLoading extends OrderState{}
class CalculateCoupon extends OrderState{}

class CouponSuccess extends OrderState{}

class CouponError extends OrderState{}

class PostOrderLoading extends OrderState{}

class PostOrderSuccess extends OrderState{}

class PostOrderError extends OrderState{}

class Reload extends OrderState{}
class ActionPaymentLoading extends OrderState{}

class ActionPaymentSuccess extends OrderState{}

class ActionPaymentError extends OrderState{}
class GetStatusPaymentLoading extends OrderState{}

class GetStatusPaymentSuccess extends OrderState{}

class GetStatusPaymentError extends OrderState{}
class CreatePaymentLoading extends OrderState{}

class CreatePaymentSuccess extends OrderState{}

class CreatePaymentError extends OrderState{}