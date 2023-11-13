part of 'attendance_bloc.dart';

// @immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceGetLoading extends AttendanceState {}

class AttendanceGetSuccess extends AttendanceState {
  final CourseAttendance courseAttendance;
  AttendanceGetSuccess({required this.courseAttendance});
}

class AttendanceDeleteSuccess extends AttendanceState {}

class AttendanceFailure extends AttendanceState {
  String message;
  AttendanceFailure({this.message = "Gagal"});
}
