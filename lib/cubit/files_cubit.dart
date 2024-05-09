import 'package:flutter_bloc/flutter_bloc.dart';

class FilesCubit extends Cubit<List<dynamic>> {
  FilesCubit() : super([]);

  void setInitValue(int index, dynamic value) {
    if (index >= 0) {
      List<dynamic> newState = List.from(state);
      value = value ?? "null";
      newState += [value];
      emit(newState);
    }
  }

  void setRadioValue(int index, dynamic value) {
    if (index >= 0 && index < state.length) {
      List<dynamic> newState = List.from(state);
      newState[index] = value;
      emit(newState);
    }
  }
}
