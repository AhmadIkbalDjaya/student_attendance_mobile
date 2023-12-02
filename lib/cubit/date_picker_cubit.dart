import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerCubit extends Cubit<DateTime?> {
  DatePickerCubit() : super(null);

  void pickDate(BuildContext context, DateTime initialDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      emit(picked);
    }
  }

  void setData(DateTime datetime) {
    emit(datetime);
  }
}
