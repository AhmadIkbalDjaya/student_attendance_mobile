import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/values/auth.dart';
import 'package:student_attendance/models/login.dart';
import 'package:student_attendance/values/constant.dart' as constant;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(UserSignOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignOut) {
        try {
          emit(LoginLoading());
          final response = await http.post(
            Uri.parse("${constant.apiUrl}/login"),
            headers: {HttpHeaders.acceptHeader: "application/json"},
            body: {
              "username": event.username,
              "password": event.password,
            },
          );
          if (response.statusCode == 200) {
            Login login = loginFromJson(response.body);
            emit(UserSignIn(login: login));
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
          } else {
            emit(LoginFailure(message: jsonDecode(response.body)["message"]));
            emit(UserSignOut());
            Auth.resetAuth();
          }
        } catch (e) {
          emit(LoginFailure(message: e.toString()));
          emit(UserSignOut());
          Auth.resetAuth();
        }
      }
    });

    on<SignOut>((event, emit) async {
      if (state is UserSignIn) {
        try {
          emit(LoginLoading());
          SharedPreferences pref = await SharedPreferences.getInstance();
          String? token = pref.getString("token");
          final response =
              await http.get(Uri.parse("${constant.apiUrl}/logout"), headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
          });
          if (response.statusCode == 200) {
            pref.remove("token");
            pref.remove("role");
            pref.remove("id");
            pref.remove("username");
            pref.remove("email");
            pref.remove("name");
            pref.remove("phone");
            pref.remove("gender");
            emit(UserSignOut());
            Auth.resetAuth();
          } else {
            Login? savedLogin = await getLoginFromSharedPreferences();
            emit(LoginFailure(message: jsonDecode(response.body)["message"]));
            if (savedLogin != null) {
              emit(UserSignIn(login: savedLogin));
            }
          }
        } catch (e) {
          Login? savedLogin = await getLoginFromSharedPreferences();
          emit(LoginFailure(message: e.toString()));
          if (savedLogin != null) {
            emit(UserSignIn(login: savedLogin));
          }
        }
      }
    });

    on<CheckSignInStatus>((event, emit) async {
      Login? savedLogin = await getLoginFromSharedPreferences();
      if (savedLogin != null) {
        emit(UserSignIn(login: savedLogin));
        Auth.setAuth(
          token: savedLogin.token,
          role: savedLogin.role,
          id: savedLogin.user.id,
          username: savedLogin.user.username,
          email: savedLogin.user.email,
          name: savedLogin.user.name,
          phone: savedLogin.user.phone,
          gender: savedLogin.user.gender,
        );
      } else {
        emit(UserSignOut());
        Auth.resetAuth();
      }
    });
  }
  Future<Login?> getLoginFromSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? role = pref.getString("role");
    int? id = pref.getInt("id");
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    String? name = pref.getString("name");
    String? phone = pref.getString("phone");
    String? gender = pref.getString("gender");

    if (token != null &&
        username != null &&
        email != null &&
        id != null &&
        role != null) {
      User user = User(
        id: id,
        username: username,
        email: email,
        name: name,
        phone: phone,
        gender: gender,
      );

      Login login = Login(
        token: token,
        user: user,
        role: role,
      );
      return login;
    }
    return null;
  }
}
