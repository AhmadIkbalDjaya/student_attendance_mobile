part of 'student_attendance_bloc.dart';

// @immutable
sealed class StudentAttendanceState {}

final class StudentAttendanceInitial extends StudentAttendanceState {}

class StudentAttendanceLoading extends StudentAttendanceState {}

class StudentAttendanceGetLoading extends StudentAttendanceState {}

class StudentAttendanceGetSuccess extends StudentAttendanceState {
  final StudentAttendance studentAttendance;
  StudentAttendanceGetSuccess({required this.studentAttendance});
}

class StudentAttendanceFailure extends StudentAttendanceState {
  String message;
  StudentAttendanceFailure({required this.message});
}
