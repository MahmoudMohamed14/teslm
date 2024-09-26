part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class Reload extends HomeState{}

class OffersLoading extends HomeState{}

class OffersSuccess extends HomeState{}

class OffersError extends HomeState{}

class CategoriesLoading extends HomeState{}

class CategoriesSuccess extends HomeState{}

class CategoriesError extends HomeState{}

final class HomeInitial extends HomeState {}

class GetProviderLoading extends HomeState{}

class GetProviderSuccess extends HomeState{}

class GetProviderError extends HomeState{}
