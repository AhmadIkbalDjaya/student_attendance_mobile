part of 'update_student_attendance_bloc.dart';

// @immutable
sealed class UpdateStudentAttendanceEvent {}

class UpdateEvent extends UpdateStudentAttendanceEvent {
  final int attendanceId;
  List<String> ids;
  List<String> statusesId;
  List<dynamic> images;
  UpdateEvent({
    required this.attendanceId,
    required this.ids,
    required this.statusesId,
    required this.images,
  });
}
