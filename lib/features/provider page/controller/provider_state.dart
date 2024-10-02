import 'package:flutter/cupertino.dart';

@immutable
sealed class ProviderState {}

class ProviderInitial extends ProviderState{}
class Reload extends ProviderState{}
class GetProviderFoodLoading extends ProviderState{}

class GetProviderFoodSuccess extends ProviderState{}

class GetProviderFoodError extends ProviderState{}
class SubmitValueEvent extends ProviderState {
  final int value;
  SubmitValueEvent(this.value);
}

