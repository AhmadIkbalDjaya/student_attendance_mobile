import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownValueCubit extends Cubit<String> {
  DropDownValueCubit() : super("");

  changeValue(String value) {
    emit(value);
  }
}