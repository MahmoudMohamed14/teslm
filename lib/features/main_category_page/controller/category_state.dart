part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryProviderLoading extends CategoryState{}

class CategoryProviderSuccess extends CategoryState{}

class CategoryProviderError extends CategoryState{}

class FilterProviderLoading extends CategoryState{}

class FilterProviderSuccess extends CategoryState{}

class FilterProviderError extends CategoryState{}
class GetAdsByCategoryLoading extends CategoryState{}

class GetAdsByCategorySuccess extends CategoryState{}

class GetAdsByCategoryError extends CategoryState{}