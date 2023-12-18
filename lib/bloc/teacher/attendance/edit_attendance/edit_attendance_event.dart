part of 'edit_attendance_bloc.dart';

// @immutable
sealed class EditAttendanceEvent {}

class EditEvent extends EditAttendanceEvent {
  final int attendanceId;
  final String title;
  final String datetime;
  EditEvent({
    required this.attendanceId,
    this.title = "",
    this.datetime = "",
  });
}