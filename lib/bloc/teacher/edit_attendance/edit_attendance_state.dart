part of 'edit_attendance_bloc.dart';

// @immutable
sealed class EditAttendanceState {}

final class EditAttendanceInitial extends EditAttendanceState {}

class EditAttendanceLoading extends EditAttendanceState {}

class EditAttendanceSuccess extends EditAttendanceState {}

class EditAttendanceFailure extends EditAttendanceState {
  final String message;
  EditAttendanceFailure({this.message = ""});
}
