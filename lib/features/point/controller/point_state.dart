part of 'point_cubit.dart';

@immutable
sealed class PointState {}

final class PointInitial extends PointState {}

class GetPointsLoading extends PointState{}

class GetPointsSuccess extends PointState{}

class GetPointsError extends PointState{}

class GetCouponsLoading extends PointState{}

class GetCouponsSuccess extends PointState{}

class GetCouponsError extends PointState{}

class RedeemPointsLoading extends PointState{}

class RedeemPointsSuccess extends PointState{}

class RedeemPointsError extends PointState{}

class GetUserPointsLoading extends PointState{}

class GetUserPointsSuccess extends PointState{}

class GetUserPointsError extends PointState{}

