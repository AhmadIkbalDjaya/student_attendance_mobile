import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCountBox extends StatelessWidget {
  const HomeCountBox({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 65,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF696CFF),
                  Color(0xFFACAEFE),
                ],
                begin: Alignment(0, 0),
                end: Alignment.bottomCenter,
              ),
            ),
            child: Skeleton.keep(
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
