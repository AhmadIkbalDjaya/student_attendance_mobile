part of 'login_bloc.dart';

// @immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  String message;
  LoginFailure({this.message = "error"});
}

class LoginSuccess extends LoginState {
  Login login;
  LoginSuccess({required this.login});
}

class LogoutSuccess extends LoginState {}
