part of 'account_cubit.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

class GetUserLoading extends AccountState{}

class GetUserSuccess extends AccountState{}

class GetUserError extends AccountState{}

class UpdateUserLoading extends AccountState{}

class UpdateUserSuccess extends AccountState{}

class UpdateUserError extends AccountState{}
