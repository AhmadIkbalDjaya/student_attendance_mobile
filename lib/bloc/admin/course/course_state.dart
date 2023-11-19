part of 'course_bloc.dart';

// @immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

class CourseGetLoading extends CourseState {}

class CourseLoading extends CourseState {}

class CourseSuccess extends CourseState {}

class CourseAddSuccess extends CourseState {}

class CourseEditSuccess extends CourseState {}

class CourseDeleteSuccess extends CourseState {}

class CourseAllSuccess extends CourseState {
  final List<Course> courses;
  CourseAllSuccess({required this.courses});
}

class CourseDetailSuccess extends CourseState {
  final Course course;
  CourseDetailSuccess({required this.course});
}

class CourseValidationError extends CourseState {
  String message;
  CourseValidationError({required this.message});
}

class CourseFailure extends CourseState {
  String message;
  CourseFailure({this.message = "error"});
}
