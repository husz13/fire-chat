part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<Message> messages;
  ChatLoaded({required this.messages});
}

final class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}

final class ChatLoading extends ChatState {}
