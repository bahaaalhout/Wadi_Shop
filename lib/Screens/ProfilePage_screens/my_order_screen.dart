import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadi_shop/Widgets/login_button.dart';
import 'package:wadi_shop/Widgets/profile_widgets/back_icon.dart';
import 'package:wadi_shop/Widgets/profile_widgets/my_order_card.dart';
import 'package:wadi_shop/constants.dart';
import 'package:wadi_shop/data/Profile%20Data/my_order_data.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});
  Future<List<MyOrder>> getOrder() async {
    final user = FirebaseAuth.instance.currentUser;

    final orderRef = FirebaseFirestore.instance
        .collection('orders')
        .doc(user!.uid)
        .collection('id');

    try {
      final snapshot = await orderRef.get();
      final orderList = snapshot.docs.map((doc) {
        final data = doc.data();

        return MyOrder(
            time: data['delivery_time'],
            orderNumber: data['order_number'],
            orderPrice: data['order_price'],
            payMethod: data['pay_method'],
            address: data['address'],
            isDelivered: false,
            deliveryDate: data['delivery_date'],
            username: data['username']);
      }).toList();

      return orderList;
    } catch (e) {
      print('Failed to retrieve favorites: $e');
      return [];
    }
  }

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
          ? FutureBuilder(
              future: getOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('لا يوجد طلبات'));
                } else {
                  final orderList = snapshot.data;
                  final reversedList = orderList!.reversed.toList();
                  return ListView.builder(
                    itemCount: reversedList.length,
                    itemBuilder: (context, index) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyOrderCard(order: reversedList[index]),
                    ),
                  );
                }
              },
            )
          : const LoginButton(),
    );
  }
}
