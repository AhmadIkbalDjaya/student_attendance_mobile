import 'package:flutter/material.dart';

class DetailIB extends StatelessWidget {
  const DetailIB({super.key, this.onPress = defaultFuntion});
  final Function onPress;
  static void defaultFuntion() {}
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPress();
      },
      icon: const Icon(
        Icons.remove_red_eye,
        color: Colors.blue,
      ),
    );
  }
}
