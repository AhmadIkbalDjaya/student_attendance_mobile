import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/models/login.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:student_attendance/values/constant.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SignIn>((event, emit) async {
      try {
        emit(LoginLoading());
        final response = await http.post(
          Uri.parse("${ApiConfig.url}/login"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "username": event.username,
            "password": event.password,
          },
        );
        if (response.statusCode == 200) {
          Login login = loginFromJson(response.body);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("token", login.token);
          pref.setString("role", login.role);
          pref.setInt("id", login.user.id);
          pref.setString("username", login.user.username);
          pref.setString("email", login.user.email);
          pref.setString("name", login.user.name ?? "");
          pref.setString("phone", login.user.phone ?? "");
          pref.setString("gender", login.user.gender ?? "");
          Auth.setAuth(
            token: login.token,
            role: login.role,
            id: login.user.id,
            username: login.user.username,
            email: login.user.email,
            name: login.user.name,
            phone: login.user.phone,
            gender: login.user.gender,
          );
          ApiConfig.setHeader(token: login.token);
          emit(LoginSuccess(login: login));
        } else {
          emit(LoginFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      try {
        emit(LoginLoading());
        SharedPreferences pref = await SharedPreferences.getInstance();
        final response = await http.get(
          Uri.parse("${ApiConfig.url}/logout"),
          headers: ApiConfig.headerWithToken,
        );
        if (response.statusCode == 200) {
          pref.remove("token");
          pref.remove("role");
          pref.remove("id");
          pref.remove("username");
          pref.remove("email");
          pref.remove("name");
          pref.remove("phone");
          pref.remove("gender");
          Auth.resetAuth();
          ApiConfig.setHeader(token: " ");
          emit(LogoutSuccess());
        } else {
          emit(LoginFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });
  }
}
