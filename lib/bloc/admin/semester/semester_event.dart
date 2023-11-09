part of 'semester_bloc.dart';

// @immutable
sealed class SemesterEvent {}

class GetAllSemesterEvent extends SemesterEvent {}

class GetDetailSemesterEvent extends SemesterEvent {
  final int semesterId;
  GetDetailSemesterEvent({required this.semesterId});
}

class AddSemesterEvent extends SemesterEvent {
  String? startYear;
  String? oddEven;
  AddSemesterEvent({
    this.startYear,
    this.oddEven,
  }) {
    startYear ??= "";
    oddEven ??= "";
  }
}

class EditSemesterEvent extends SemesterEvent {
  int id;
  String? startYear;
  String? oddEven;
  EditSemesterEvent({
    required this.id,
    this.startYear,
    this.oddEven,
  }) {
    startYear ??= "";
    oddEven ??= "";
  }
}

class DeleteSemesterEvent extends SemesterEvent {
  int id;
  DeleteSemesterEvent({required this.id});
}
