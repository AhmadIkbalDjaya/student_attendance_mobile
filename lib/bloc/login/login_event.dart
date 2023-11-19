part of 'login_bloc.dart';

// @immutable
sealed class LoginEvent {}

class TryLoginEvent extends LoginEvent {
  String? username;
  String? password;
  TryLoginEvent({this.username, this.password}){
    username ??= "";
    password ??= "";
  }

}
