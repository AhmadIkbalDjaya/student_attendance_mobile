import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/models/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(UserSignOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignOut) {
        try {
          emit(LoginLoading());
          final response = await http.post(
            Uri.parse("https://mobile.attendance.sman17gowa.com/api/login"),
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
            // pref.setBool("login", true);
            pref.setString("token", login.token);
            pref.setString("role", login.role);
            pref.setInt("id", login.user.id);
            pref.setString("username", login.user.username);
            pref.setString("email", login.user.email);
            pref.setString("name", login.user.name ?? "");
            pref.setString("phone", login.user.phone ?? "");
            pref.setString("gender", login.user.gender ?? "");
          } else {
            emit(LoginFailure(message: jsonDecode(response.body)["message"]));
            emit(UserSignOut());
          }
        } catch (e) {
          emit(LoginFailure(message: e.toString()));
          emit(UserSignOut());
        }
      }
    });

    on<SignOut>((event, emit) async {
      if (state is UserSignIn) {
        try {
          // emit(LoginLoading());
          SharedPreferences pref = await SharedPreferences.getInstance();
          String? token = pref.getString("token");
          final response = await http.get(
              Uri.parse("https://mobile.attendance.sman17gowa.com/api/logout"),
              headers: {
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
          }
          // } else {
          //   // emit(LoginFailure(message: jsonDecode(response.body)["message"]));
          //   // emit(UserSignIn(login: login));
          // }
        } catch (e) {
          // emit(LoginFailure(message: e.toString()));
          // emit(UserSignIn(login: login));
        }
      }
    });

    on<CheckSignInStatus>((event, emit) async {
      Login? savedLogin = await getLoginFromSharedPreferences();
      if (savedLogin != null) {
        emit(UserSignIn(login: savedLogin));
      } else {
        emit(UserSignOut());
      }
    });
  }
  Future<Login?> getLoginFromSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String? isLogin = pref.getString("token");
    String? token = pref.getString("token");
    String? role = pref.getString("role");
    int? id = pref.getInt("id");
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    String? name = pref.getString("name");
    String? phone = pref.getString("phone");
    String? gender = pref.getString("gender");

    // Memeriksa apakah data lengkap sebelum membuat instance Login
    if (token != null &&
        username != null &&
        email != null &&
        id != null &&
        role != null) {
      // Membuat instance User terlebih dahulu
      User user = User(
        id: id,
        username: username,
        email: email,
        name: name,
        phone: phone,
        gender: gender,
      );

      // Membuat instance Login dengan nilai dari SharedPreferences
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
