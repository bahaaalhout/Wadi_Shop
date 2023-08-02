import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadi_shop/Widgets/login_button.dart';
import 'package:wadi_shop/Widgets/profile_widgets/back_icon.dart';
import 'package:wadi_shop/Widgets/profile_widgets/my_order_card.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/data/Profile%20Data/my_order_data.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'طلباتي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [BackIcon()],
      ),
      body: currentUserId != null
          ? ListView.builder(
              itemCount: myOrderData.length,
              itemBuilder: (context, index) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: MyOrderCard(order: myOrderData[index])),
            )
          : const LoginButton(),
    );
  }
}
