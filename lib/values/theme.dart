import 'package:flutter/material.dart';

class CustomTheme {
  static const DataTableThemeData customDataTableTheme = DataTableThemeData(
    horizontalMargin: 10,
    columnSpacing: 25,
    dataRowMinHeight: 42,
    dataRowMaxHeight: 42,
    headingRowHeight: 42,
    headingTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.white,
      backgroundColor: const Color(0xFF696CFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
  );

  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    floatingLabelStyle: TextStyle(
      color: Color(0xFF696CFF),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF696CFF),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF696CFF),
      ),
    ),
    border: OutlineInputBorder(),
  );

  static BoxDecoration headerDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF696CFF),
          Color(0xFFACAEFE),
        ],
        // begin: Alignment(0.6, 0),
        // end: Alignment.bottomRight,
        begin: Alignment(0, 0),
        end: Alignment.bottomCenter,
      ),
    );
  }

  static BoxDecoration contentDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(25, 0, 0, 0),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 3),
        ),
      ],
    );
  }
}
