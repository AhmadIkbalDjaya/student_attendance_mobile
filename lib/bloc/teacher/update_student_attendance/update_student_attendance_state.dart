part of 'update_student_attendance_bloc.dart';

// @immutable
sealed class UpdateStudentAttendanceState {}

final class UpdateStudentAttendanceInitial
    extends UpdateStudentAttendanceState {}

class UpdateStudentAttendanceLoading extends UpdateStudentAttendanceState {}

class UpdateStudentAttendanceSuccess extends UpdateStudentAttendanceState {}

class UpdateStudentAttendanceFailure extends UpdateStudentAttendanceState {
  final String message;
  UpdateStudentAttendanceFailure({required this.message});
}
