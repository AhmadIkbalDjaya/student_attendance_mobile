part of 'teacher_course_bloc.dart';

// @immutable
sealed class TeacherCourseState {}

final class TeacherCourseInitial extends TeacherCourseState {}

class TeacherCourseLoading extends TeacherCourseState {}

class TeacherCourseGetLoading extends TeacherCourseState {}

class TeacherCourseSuccess extends TeacherCourseState {}

class TeacherCourseGetSuccess extends TeacherCourseState {
  final List<TeacherCourse> teacherCourses;
  TeacherCourseGetSuccess({required this.teacherCourses});
}

class TeacherCourseFailure extends TeacherCourseState {
  final String message;
  TeacherCourseFailure({required this.message});
}
