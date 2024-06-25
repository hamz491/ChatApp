part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String ErrorMessage;

  LoginFailure({required this.ErrorMessage});
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
 
}

final class RegisterFailure extends AuthState {
  final String ErrorMessage;

  RegisterFailure({required this.ErrorMessage});
}
