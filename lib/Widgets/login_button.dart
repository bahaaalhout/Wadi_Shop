import 'package:flutter/material.dart';

import '../Screens/otp_screen.dart';
import '../constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('سجل دخول لتستطيع استخدام هذه الميزة'),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const OTPScreen(),
            ));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            foregroundColor: kprimaryColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: kprimaryColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text('تسجيل الدخول'),
        ),
      ],
    ));
  }
}
