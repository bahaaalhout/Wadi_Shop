import 'package:flutter/material.dart';

import '../../constants.dart';

class GettingAddressButton extends StatelessWidget {
  const GettingAddressButton(
      {super.key, required this.title, required this.press});
  final String title;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        foregroundColor: Colors.white,
        backgroundColor: kprimaryColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: kprimaryColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(title),
    );
  }
}
