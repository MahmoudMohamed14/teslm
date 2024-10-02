part of 'coupons_cubit.dart';

@immutable
sealed class CouponsState {}

final class CouponsInitial extends CouponsState {}

class GetCouponsLoading extends CouponsState {}

class GetCouponsSuccess extends CouponsState {}

class GetCouponsError extends CouponsState {}
