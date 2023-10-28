part of 'student_bloc.dart';

// @immutable
sealed class StudentEvent {}

class GetAllStudentEvent extends StudentEvent {}

class GetDetailStudentEvent extends StudentEvent {
  final int studentId;
  GetDetailStudentEvent({required this.studentId});
}
