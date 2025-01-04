import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyCard({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            subTitle,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
