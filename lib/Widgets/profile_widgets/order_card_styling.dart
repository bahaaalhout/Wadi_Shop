import 'package:flutter/material.dart';

class CardColumn extends StatelessWidget {
  const CardColumn({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey[700]),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
