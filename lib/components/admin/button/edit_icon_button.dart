import 'package:flutter/material.dart';

class EditIB extends StatelessWidget {
  const EditIB({super.key, this.onPress = defaultFunction});
  final Function onPress;
  static void defaultFunction() {}
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPress();
      },
      icon: const Icon(
        Icons.edit_square,
        color: Colors.amber,
      ),
    );
  }
}
