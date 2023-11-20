part of 'account_setting_bloc.dart';

// @immutable
sealed class AccountSettingEvent {}

class UpdateProfileEvent extends AccountSettingEvent {
  String username;
  String name;
  String email;
  String phone;
  String gender;
  UpdateProfileEvent({
    this.username = "",
    this.name = "",
    this.email = "",
    this.phone = "",
    this.gender = "",
  });
}

class UpdatePassword extends AccountSettingEvent {
  String oldPassword;
  String newPassword;
  String confirmNewPassword;
  UpdatePassword({
    this.oldPassword = "",
    this.newPassword = "",
    this.confirmNewPassword = "",
  });
}
