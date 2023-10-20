import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
