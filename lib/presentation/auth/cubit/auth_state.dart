part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess<T> extends AuthState {
  final T data;
  AuthSuccess(this.data);
}

final class AuthError extends AuthState {
  final FirebaseException error;
  AuthError(this.error);
}
