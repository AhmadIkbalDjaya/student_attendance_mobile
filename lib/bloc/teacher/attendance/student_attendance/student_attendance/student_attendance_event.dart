part of 'student_attendance_bloc.dart';

// @immutable
sealed class StudentAttendanceEvent {}

class GetStudentAttendanceEvent extends StudentAttendanceEvent {
  final int attendanceId;
  GetStudentAttendanceEvent({required this.attendanceId});
}
