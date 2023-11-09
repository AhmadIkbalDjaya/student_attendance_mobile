part of 'course_bloc.dart';

// @immutable
sealed class CourseEvent {}

class GetAllCourseEvent extends CourseEvent {}

class GetDetailCourseEvent extends CourseEvent {
  final int id;
  GetDetailCourseEvent({required this.id});
}

class AddCourseEvent extends CourseEvent {
  String? name;
  String? classId;
  String? teacherId;
  String? semesterId;
  AddCourseEvent({
    this.name,
    this.classId,
    this.teacherId,
    this.semesterId,
  }) {
    name ??= "";
    classId ??= "";
    teacherId ??= "";
    semesterId ??= "";
  }
}

class EditCourseEvent extends CourseEvent {
  final int id;
  String? name;
  String? classId;
  String? teacherId;
  String? semesterId;
  EditCourseEvent({
    required this.id,
    this.name,
    this.classId,
    this.teacherId,
    this.semesterId,
  }) {
    name ??= "";
    classId ??= "";
    teacherId ??= "";
    semesterId ??= "";
  }
}

class DeleteCourseEvent extends CourseEvent {
  final int id;
  DeleteCourseEvent({required this.id});
}
