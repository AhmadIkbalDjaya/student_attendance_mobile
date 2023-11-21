part of 'auth_bloc.dart';

// @immutable
sealed class AuthEvent {}

class CheckAuth extends AuthEvent {}

class SetSignIn extends AuthEvent {}

class SetSignOut extends AuthEvent {}
