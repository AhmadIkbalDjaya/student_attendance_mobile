part of 'create_attendance_bloc.dart';

// @immutable
sealed class CreateAttendanceEvent {}

class CreateNewAttendanceEvent extends CreateAttendanceEvent {
  final String courseId;
  final String title;
  final String datetime;
  CreateNewAttendanceEvent({
    this.courseId = "",
    this.title = "",
    this.datetime = "",
  });
}
