import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not Found",
            style: TextStyle(
              fontSize: 60,
              color: Color(0xFF696CFF),
            ),
          ),
        ],
      ),
    );
  }
}
