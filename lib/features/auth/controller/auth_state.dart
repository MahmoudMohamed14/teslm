part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ChangeLangStatesApp extends AuthState {}
class OtpCheckLoading extends AuthState{}

class OtpCheckSuccess extends AuthState{}

class OtpCheckError extends AuthState{}

class LoginOTPLoading extends AuthState{}

class LoginOTPSuccess extends AuthState{}

class LoginOTPError extends AuthState{
  final error;
  LoginOTPError({this.error});
}
class LoginLoading extends AuthState{}

class LoginSuccess extends AuthState{}

class LoginError extends AuthState{
  final error;
  LoginError(this.error);
}

