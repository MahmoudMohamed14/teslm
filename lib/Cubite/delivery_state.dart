part of 'delivery_cubit.dart';

@immutable
sealed class DeliveryState {}

final class DeliveryInitial extends DeliveryState {}

class OtherPage extends DeliveryState{}

class ViewChange extends DeliveryState{}

class Reload extends DeliveryState{}

class OffersLoading extends DeliveryState{}

class OffersSuccess extends DeliveryState{}

class OffersError extends DeliveryState{}

class CategoriesLoading extends DeliveryState{}

class CategoriesSuccess extends DeliveryState{}

class CategoriesError extends DeliveryState{}

class CategoryProviderLoading extends DeliveryState{}

class CategoryProviderSuccess extends DeliveryState{}

class CategoryProviderError extends DeliveryState{}

class FilterProviderLoading extends DeliveryState{}

class FilterProviderSuccess extends DeliveryState{}

class FilterProviderError extends DeliveryState{}

class SubmitValueEvent extends DeliveryState {
  final int value;
  SubmitValueEvent(this.value);
}

class LoginLoading extends DeliveryState{}

class LoginSuccess extends DeliveryState{}

class LoginError extends DeliveryState{
  final error;
  LoginError(this.error);
}

class OtpCheckLoading extends DeliveryState{}

class OtpCheckSuccess extends DeliveryState{}

class OtpCheckError extends DeliveryState{}

class LoginOTPLoading extends DeliveryState{}

class LoginOTPSuccess extends DeliveryState{}

class LoginOTPError extends DeliveryState{}

class ChangeLanguageSuccess extends DeliveryState{}

class GetUserLoading extends DeliveryState{}

class GetUserSuccess extends DeliveryState{}

class GetUserError extends DeliveryState{}

class UpdateUserLoading extends DeliveryState{}

class UpdateUserSuccess extends DeliveryState{}

class UpdateUserError extends DeliveryState{}

class GetProviderLoading extends DeliveryState{}

class GetProviderSuccess extends DeliveryState{}

class GetProviderError extends DeliveryState{}

class GetProviderFoodLoading extends DeliveryState{}

class GetProviderFoodSuccess extends DeliveryState{}

class GetProviderFoodError extends DeliveryState{}

class CouponLoading extends DeliveryState{}

class CouponSuccess extends DeliveryState{}

class CouponError extends DeliveryState{}

class PostOrderLoading extends DeliveryState{}

class PostOrderSuccess extends DeliveryState{}

class PostOrderError extends DeliveryState{}

class GetOrdersLoading extends DeliveryState{}

class GetOrdersSuccess extends DeliveryState{}

class GetOrdersError extends DeliveryState{}

class RedeemPointsLoading extends DeliveryState{}

class RedeemPointsSuccess extends DeliveryState{}

class RedeemPointsError extends DeliveryState{}

class GetPointsLoading extends DeliveryState{}

class GetPointsSuccess extends DeliveryState{}

class GetPointsError extends DeliveryState{}

class GetCouponsLoading extends DeliveryState{}

class GetCouponsSuccess extends DeliveryState{}

class GetCouponsError extends DeliveryState{}


class OtpInitial extends DeliveryState {}

class OtpSending extends DeliveryState {}

class OtpSentSuccess extends DeliveryState {}

class OtpSentFailure extends DeliveryState {
  final String error;
  OtpSentFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class OtpVerifying extends DeliveryState {}

class OtpVerifySuccess extends DeliveryState {}

class OtpVerifyFailure extends DeliveryState {
  final String error;
  OtpVerifyFailure(this.error);

  @override
  List<Object?> get props => [error];
}


