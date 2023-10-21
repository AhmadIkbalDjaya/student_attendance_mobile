import 'package:flutter/material.dart';

class DetailIB extends StatelessWidget {
  const DetailIB({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: const Icon(
        Icons.remove_red_eye,
        color: Colors.blue,
      ),
    );
  }
}
