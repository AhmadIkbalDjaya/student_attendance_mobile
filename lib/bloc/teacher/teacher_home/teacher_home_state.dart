part of 'teacher_home_bloc.dart';

// @immutable
sealed class TeacherHomeState {}

final class TeacherHomeInitial extends TeacherHomeState {}

class TeacherHomeLoading extends TeacherHomeState {}

class TeacherHomeSuccess extends TeacherHomeState {
  TeacherHome teacherHome;
  TeacherHomeSuccess({required this.teacherHome});
}

class TeacherHomeFailure extends TeacherHomeState {
  String message;
  TeacherHomeFailure({this.message = "error"});
}

class InvalidToken extends TeacherHomeState {}
