part of 'account_setting_bloc.dart';

// @immutable
sealed class AccountSettingState {}

final class AccountSettingInitial extends AccountSettingState {}

class Loading extends AccountSettingState {}

class UpdateSuccess extends AccountSettingState {}

class ValidationError extends AccountSettingState {
  String message;
  ValidationError({required this.message});
}

class Failure extends AccountSettingState {
  String message;
  Failure({this.message = "error"});
}
