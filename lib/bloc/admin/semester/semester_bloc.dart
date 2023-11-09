import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/admin/semester.dart';

part 'semester_event.dart';
part 'semester_state.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  SemesterBloc() : super(SemesterInitial()) {
    on<GetAllSemesterEvent>((event, emit) async {
      emit(SemesterGetLoading());
      final response = await http.get(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/semester"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(SemesterAllSuccess(semesters: semestersFromJson(response.body)));
    });

    on<GetDetailSemesterEvent>((event, emit) async {
      emit(SemesterGetLoading());
      final response = await http.get(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/semester/${event.semesterId}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      emit(SemesterDetailSuccess(semester: semesterFromJson(response.body)));
    });

    on<AddSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/semester"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "start_year": event.startYear,
            "odd_even": event.oddEven,
          },
        );
        if (response.statusCode == 200) {
          emit(SemesterAddSuccess());
        } else {
          var message = jsonDecode(response.body)["message"];
          emit(SemesterValidationError(message: message));
        }
      } catch (e) {
        emit(SemesterFailure());
      }
    });

    on<EditSemesterEvent>((event, emit) async {
      try {
        emit(SemesterLoading());
        final response = await http.post(
          Uri.parse(
              "https://mobile.attendance.sman17gowa.com/api/admin/semester/${event.id}?_method=put"),
          headers: {HttpHeaders.acceptHeader: "application/json"},
          body: {
            "start_year": event.startYear,
            "odd_even": event.oddEven,
          },
        );
        if (response.statusCode == 200) {
          emit(SemesterEditSuccess());
        } else {
          final message = jsonDecode(response.body)["message"];
          emit(SemesterValidationError(message: message));
        }
      } catch (e) {
        emit(SemesterFailure());
      }
    });

    on<DeleteSemesterEvent>((event, emit) async {
      emit(SemesterLoading());
      final response = await http.delete(
        Uri.parse(
            "https://mobile.attendance.sman17gowa.com/api/admin/semester/${event.id}"),
        headers: {HttpHeaders.acceptHeader: "application/json"},
      );
      if (response.statusCode == 200) {
        emit(SemesterDeleteSuccess());
      } else {
        emit(SemesterFailure());
      }
    });
  }
}
