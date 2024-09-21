part of 'app_dark_light_cubit.dart';

@immutable
sealed class AppDarkLightState {}

final class AppDarkLightInitial extends AppDarkLightState {}

class AppcubitInitial extends AppDarkLightState {}

class ChangeMode extends AppDarkLightState{}

class ChangeLangStatesApp extends AppDarkLightState {}
