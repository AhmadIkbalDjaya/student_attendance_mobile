part of 'attendance_bloc.dart';

// @immutable
sealed class AttendanceEvent {}

class GetCourseAttendanceEvent extends AttendanceEvent {
  final int courseId;
  GetCourseAttendanceEvent({required this.courseId});
}

class DeleteAttendanceEvent extends AttendanceEvent {
  final int attendanceId;
  DeleteAttendanceEvent({required this.attendanceId});
}
