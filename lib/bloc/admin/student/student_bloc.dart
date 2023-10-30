// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<GetAllStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final response = await http.get(
        Uri.parse("https://mobile.attendance.sman17gowa.com/api/admin/student"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(StudentSuccess(students: studentsFromJson(response.body)));
    });
    on<GetDetailStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final response = await http.get(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/student/${event.studentId}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(StudentDetailSuccess(student: studentFromJson(response.body)));
    });
    on<AddStudentEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final response = await http.post(
            Uri.parse(
                "https://mobile.attendance.sman17gowa.com/api/admin/student"),
            body: {
              "nis": event.nis,
              "name": event.name,
              "gender": event.gender,
              "claass_id": event.classId
            },
            headers: {
              HttpHeaders.acceptHeader: "application/json",
            });
        if (response.statusCode == 200) {
          emit(AddEditStudentSuccess());
          Navigator.pushNamed(event.context, "/admin/student");
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text("Siswa Berhasil Ditambahkan"),
            ),
          );
        } else {
          var message = json.decode(response.body)['message'];
          emit(StudentValidationError(message: "error"));
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        }
      } catch (e) {
        emit(StudentFailure());
      }
    });
    on<EditStudentEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final response = await http.post(
            Uri.parse(
                "https://mobile.attendance.sman17gowa.com/api/admin/student/${event.id}?_method=put"),
            body: {
              "nis": event.nis,
              "name": event.name,
              "gender": event.gender,
              "claass_id": event.classId
            },
            headers: {
              HttpHeaders.acceptHeader: "application/json",
            });
        if (response.statusCode == 200) {
          emit(AddEditStudentSuccess());
          Navigator.pushNamed(event.context, "/admin/student");
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text("Siswa Berhasil DiEdit"),
            ),
          );
        } else {
          var message = json.decode(response.body)['message'];
          emit(StudentValidationError(message: "error"));
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        }
      } catch (e) {
        emit(StudentFailure());
      }
    });
  }
}
