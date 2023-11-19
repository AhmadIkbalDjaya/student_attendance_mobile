part of 'login_bloc.dart';

// @immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  String message;
  LoginFailure({this.message = "error"});
}

class UserSignIn extends LoginState {
  final Login login;
  UserSignIn({required this.login});
}

class UserSignOut extends LoginState {}
