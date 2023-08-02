import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.press,
      required this.icon,
      required this.color});
  final void Function() press;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 35,
      ),
      child: IconButton(
        onPressed: press,
        icon: Icon(
          icon,
          color: color,
          size: 25,
        ),
      ),
    );
  }
}
