part of 'create_attendance_bloc.dart';

// @immutable
sealed class CreateAttendanceEvent {}

class CreateNewAttendanceEvent extends CreateAttendanceEvent {
  final int courseId;
  final String title;
  final String datetime;
  CreateNewAttendanceEvent({
    required this.courseId,
    this.title = "",
    this.datetime = "",
  });
}
