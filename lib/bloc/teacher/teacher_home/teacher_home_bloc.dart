import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/teacher/teacher_home.dart';
import 'package:student_attendance/values/constant.dart' as constant;

part 'teacher_home_event.dart';
part 'teacher_home_state.dart';

class TeacherHomeBloc extends Bloc<TeacherHomeEvent, TeacherHomeState> {
  TeacherHomeBloc() : super(TeacherHomeInitial()) {
    on<GetTeacherHomeEvent>((event, emit) async {
      try {
        emit(TeacherHomeLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/teacher/home"),
          headers: constant.apiHeaderWithToken,
        );
        if (response.statusCode == 200) {
          emit(TeacherHomeSuccess(
            teacherHome: teacherHomeFromJson(response.body),
          ));
        } else {
          emit(
            TeacherHomeFailure(message: jsonDecode(response.body)["message"]),
          );
        }
      } catch (e) {
        emit(
          TeacherHomeFailure(message: e.toString()),
        );
      }
    });
  }
}
