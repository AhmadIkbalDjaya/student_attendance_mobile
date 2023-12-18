import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/values/constant.dart' as constant;
import 'package:student_attendance/models/admin/teacher.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(TeacherInitial()) {
    on<GetAllTeacherEvent>((event, emit) async {
      try {
        emit(TeacherGetLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/teacher"),
          headers: constant.apiHeaderWithToken,
        );
        if (response.statusCode == 200) {
          emit(TeacherAllSuccess(teachers: teachersFromJson(response.body)));
        } else {
          emit(TeacherFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(TeacherFailure(message: e.toString()));
      }
    });

    on<GetDetailTeacherEvent>((event, emit) async {
      try {
        emit(TeacherGetLoading());
        final response = await http.get(
          Uri.parse("${constant.apiUrl}/admin/teacher/${event.teacherId}"),
          headers: constant.apiHeaderWithToken,
        );
        if (response.statusCode == 200) {
          emit(TeacherDetailSuccess(teacher: teacherFromJson(response.body)));
        } else {
          emit(TeacherFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(TeacherFailure(message: e.toString()));
      }
    });

    on<AddTeacherEvent>((event, emit) async {
      try {
        emit(TeacherLoading());
        final response = await http.post(
          Uri.parse("${constant.apiUrl}/admin/teacher"),
          headers: constant.apiHeaderWithToken,
          body: {
            "username": event.username,
            "password": event.password,
            "email": event.email,
            "name": event.name,
            "phone": event.phone,
            "gender": event.gender,
          },
        );
        if (response.statusCode == 200) {
          emit(TeacherAddSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(TeacherValidationError(message: message));
        }
      } catch (e) {
        emit(TeacherFailure(message: e.toString()));
      }
    });

    on<EditTeacherEvent>((event, emit) async {
      try {
        emit(TeacherLoading());
        final response = await http.post(
            Uri.parse(
                "${constant.apiUrl}/admin/teacher/${event.id}?_method=put"),
            body: {
              "username": event.username,
              "password": event.password,
              "email": event.email,
              "name": event.name,
              "phone": event.phone,
              "gender": event.gender,
            },
            headers: {
              HttpHeaders.acceptHeader: "application/json",
            });
        if (response.statusCode == 200) {
          emit(TeacherEditSuccess());
        } else {
          var message = json.decode(response.body)['message'];
          emit(TeacherValidationError(message: message));
        }
      } catch (e) {
        emit(TeacherFailure(message: e.toString()));
      }
    });

    on<DeleteTeacherEvent>((event, emit) async {
      try {
        emit(TeacherLoading());
        final response = await http.delete(
          Uri.parse("${constant.apiUrl}/admin/teacher/${event.id}"),
          headers: constant.apiHeaderWithToken,
        );
        if (response.statusCode == 200) {
          emit(TeacherDeleteSuccess());
        } else {
          emit(TeacherFailure(message: jsonDecode(response.body)["message"]));
        }
      } catch (e) {
        emit(TeacherFailure(message: e.toString()));
      }
    });

    on<SetTeacherPasswordEvent>(
      (event, emit) async {
        try {
          emit(TeacherLoading());
          final response = await http.post(
            Uri.parse("${constant.apiUrl}/admin/teacher/setPass/${event.id}"),
            body: {"password": event.password},
            headers: constant.apiHeaderWithToken,
          );
          if (response.statusCode == 200) {
            emit(TeacherSetPassSuccess());
          } else {
            emit(TeacherFailure(message: jsonDecode(response.body)["message"]));
          }
        } catch (e) {
          emit(TeacherFailure(message: e.toString()));
        }
      },
    );
  }
}
