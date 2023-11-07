part of 'claass_bloc.dart';

// @immutable
sealed class ClaassEvent {}

class GetAllClaassEvent extends ClaassEvent {}

class GetDetailClaassEvent extends ClaassEvent {
  final int claassId;
  GetDetailClaassEvent({required this.claassId});
}

class AddClaassEvent extends ClaassEvent {
  String? majorId;
  String? level;
  String? name;
  AddClaassEvent({
    this.majorId,
    this.level,
    this.name,
  }) {
    majorId ??= "";
    level ??= "";
    name ??= "";
  }
}

class EditClaassEvent extends ClaassEvent {
  int id;
  String? majorId;
  String? level;
  String? name;
  EditClaassEvent({
    required this.id,
    this.majorId,
    this.level,
    this.name,
  }) {
    majorId ??= "";
    level ??= "";
    name ??= "";
  }
}

class DeleteClaassEvent extends ClaassEvent {
  int id;
  DeleteClaassEvent({required this.id});
}
