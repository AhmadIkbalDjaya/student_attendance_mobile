import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/models/admin/teacher.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/auth.dart';
import 'package:student_attendance/values/constant.dart' as constant;

part 'account_setting_event.dart';
part 'account_setting_state.dart';

class AccountSettingBloc
    extends Bloc<AccountSettingEvent, AccountSettingState> {
  AccountSettingBloc() : super(AccountSettingInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(Loading());
        final response = await http.post(
          Uri.parse("${constant.apiUrl}/teacher/updateProfil"),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Auth.token}"
          },
          body: {
            "username": event.username,
            "name": event.name,
            "email": event.email,
            "phone": event.phone,
            "gender": event.gender,
          },
        );
        if (response.statusCode == 200) {
          emit(UpdateSuccess());
          Teacher teacher = teacherFromJson(response.body);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("username", teacher.username);
          pref.setString("email", teacher.email.toString());
          pref.setString("name", teacher.name);
          pref.setString("phone", teacher.phone.toString());
          pref.setString("gender", teacher.gender.toString());
          Auth.setAuth(
            token: Auth.token,
            role: Auth.role,
            id: Auth.id,
            username: teacher.username,
            email: teacher.email,
            name: teacher.name,
            phone: teacher.phone,
            gender: teacher.gender,
          );
        } else {
          emit(ValidationError(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(Failure(message: e.toString()));
      }
    });

    on<UpdatePassword>((event, emit) async {
      try {
        emit(Loading());
        final response = await http.post(
          Uri.parse("${constant.apiUrl}/teacher/changePass"),
          headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Auth.token}",
          },
          body: {
            "old_password": event.oldPassword,
            "new_password": event.newPassword,
            "new_password_confirmation": event.confirmNewPassword,
          },
        );
        if (response.statusCode == 200) {
          emit(UpdateSuccess());
        } else {
          emit(ValidationError(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(ValidationError(message: e.toString()));
      }
    });
  }
}
