part of 'create_attendance_bloc.dart';

// @immutable
sealed class CreateAttendanceState {}

final class CreateAttendanceInitial extends CreateAttendanceState {}

class CreateAttendanceLoading extends CreateAttendanceState {}

class CreateAttendanceSuccess extends CreateAttendanceState {}

class CreateAttendanceFailure extends CreateAttendanceState {
  final String message;
  CreateAttendanceFailure({this.message = ""});
}
