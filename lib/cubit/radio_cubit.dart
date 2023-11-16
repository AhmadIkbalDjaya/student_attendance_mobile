import 'package:flutter_bloc/flutter_bloc.dart';

class RadioCubit extends Cubit<List<String>> {
  RadioCubit() : super([]);

  void setInitValue(int index, String value) {
    if (index >= 0) {
      List<String> newState = List.from(state);
      newState += [value];
      emit(newState);
    }
  }

  void setRadioValue(int index, String value) {
    if (index >= 0 && index < state.length) {
      List<String> newState = List.from(state);
      newState[index] = value;
      emit(newState);
    }
  }
}