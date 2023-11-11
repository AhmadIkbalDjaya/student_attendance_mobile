import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/teacher.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(TeacherInitial()) {
    on<GetAllTeacherEvent>((event, emit) async {
      emit(TeacherGetLoading());
      final response = await http.get(
        Uri.parse("https://mobile.attendance.sman17gowa.com/api/admin/teacher"),
        headers: {HttpHeaders.acceptHeader: "apllication/json"},
      );
      emit(TeacherAllSuccess(teachers: teachersFromJson(response.body)));
    });

    on<GetDetailTeacherEvent>((event, emit) async {
      emit(TeacherGetLoading());
      final response = await http.get(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/teacher/${event.teacherId}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(TeacherDetailSuccess(teacher: teacherFromJson(response.body)));
    });

    on<AddTeacherEvent>((event, emit) async {
      try {
        emit(TeacherLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/teacher"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
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
        emit(TeacherFailure());
      }
    });

    on<EditTeacherEvent>((event, emit) async {
      try {
        emit(TeacherLoading());
        final response = await http.post(
            Uri.parse(
                "https://mobile.attendance.sman17gowa.com/api/admin/teacher/${event.id}?_method=put"),
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
        emit(TeacherFailure());
      }
    });

    on<DeleteTeacherEvent>((event, emit) async {
      emit(TeacherLoading());
      final response = await http.delete(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/teacher/${event.id}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      if (response.statusCode == 200) {
        emit(TeacherDeleteSuccess());
      } else {
        emit(TeacherFailure());
      }
    });
  }
}