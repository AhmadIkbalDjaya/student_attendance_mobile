part of 'login_bloc.dart';

// @immutable
sealed class LoginEvent {}

class SignIn extends LoginEvent {
  String? username;
  String? password;
  SignIn({this.username, this.password}) {
    username ??= "";
    password ??= "";
  }
}

class SignOut extends LoginEvent {}
