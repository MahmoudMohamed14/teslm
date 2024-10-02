part of 'chat_controller_cubit.dart';

@immutable
sealed class ChatControllerState {}

final class ChatControllerInitial extends ChatControllerState {}

class Reload extends ChatControllerState{}

class MessageLoading extends ChatControllerState{}

class MessageSuccess extends ChatControllerState{}

class MessageError extends ChatControllerState{}

class GetChatCallCenterLoading extends ChatControllerState{}

class GetChatCallCenterSuccess extends ChatControllerState{}

class GetChatCallCenterError extends ChatControllerState{}

class ReloadChat extends ChatControllerState{}
