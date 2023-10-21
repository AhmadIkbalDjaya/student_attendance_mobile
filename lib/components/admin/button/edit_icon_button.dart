import 'package:flutter/material.dart';

class EditIB extends StatelessWidget {
  const EditIB({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: const Icon(
        Icons.edit_square,
        color: Colors.amber,
      ),
    );
  }
}
