import 'package:flutter/material.dart';

import '../../constants.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({
    super.key,
    required this.press,
    required this.title,
  });
  final void Function() press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: ksecoundaryColor,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: press,
          child: const Text(
            'أنظر الكل',
            style: TextStyle(
              color: ksecoundaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
