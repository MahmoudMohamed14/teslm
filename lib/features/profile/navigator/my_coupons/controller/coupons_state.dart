part of 'coupons_cubit.dart';

@immutable
sealed class CouponsState {}

final class CouponsInitial extends CouponsState {}

class GetCouponsLoading extends CouponsState {}

class GetCouponsSuccess extends CouponsState {}

class GetCouponsError extends CouponsState {}

class SaveCouponsLoading extends CouponsState {}

class SaveCouponsSuccess extends CouponsState {}

class SaveCouponsError extends CouponsState {}