part of 'auth_bloc.dart';

// @immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class UserSignOut extends AuthState {}

class UserSignIn extends AuthState {
  Login login;
  UserSignIn({required this.login});
}
