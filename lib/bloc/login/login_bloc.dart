import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<TryLoginEvent>((event, emit) async {
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
          emit(LoginSuccess(login: loginFromJson(response.body)));
        } else {
          emit(LoginFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(LoginFailure(message: e.toString()));
      }
    });
  }
}
