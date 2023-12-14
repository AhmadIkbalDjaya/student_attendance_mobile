part of 'admin_home_bloc.dart';

// @immutable
sealed class AdminHomeState {}

final class AdminHomeInitial extends AdminHomeState {}

class AdminHomeLoading extends AdminHomeState {}

class AdminHomeSuccess extends AdminHomeState {
  AdminHome adminHome;
  AdminHomeSuccess({required this.adminHome});
}

class AdminHomeFailure extends AdminHomeState {
  String message;
  AdminHomeFailure({this.message = "error"});
}

class InvalidToken extends AdminHomeState {}
