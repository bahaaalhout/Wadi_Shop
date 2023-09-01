import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Widgets/login_button.dart';
import 'package:wadi_shop/Widgets/my_button.dart';
import 'package:wadi_shop/Widgets/profile_widgets/address_card.dart';

import 'package:wadi_shop/constants.dart';

import '../../Models/place.dart';
import '../../Provider/get_address_provider.dart';
import '../../Widgets/profile_widgets/add_address.dart';
import '../../Widgets/profile_widgets/back_icon.dart';

class MyAddressScreen extends ConsumerWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kprimaryColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'عناويني',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: const [
            BackIcon(),
          ]),
      body: currentUserId != null
          ? Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('address')
                      .doc(auth.currentUser!.uid)
                      .collection('id')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Expanded(
                        child: Center(child: Text('أضف عنوان جديد')),
                      );
                    } else {
                      final addressref = snapshot.data!.docs;
                      final addressList = addressref.map((doc) {
                        final data = doc.data();
                        return Place(
                          title: data['title'],
                          location: PlaceLocation(
                            latitude: data['lat'],
                            longitude: data['lng'],
                            address: data['address'],
                          ),
                          id: data['id'],
                        );
                      }).toList();
                      return Expanded(
                        child: ListView.builder(
                          itemCount: addressList.length,
                          itemBuilder: (context, index) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: AddressCard(
                              address: addressList[index],
                              deleteItem: () {
                                ref
                                    .read(getAddressProvider.notifier)
                                    .deleteAddress(
                                        addressList[index].id, context);
                                // deleteAddress();
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                MyButtonWidget(
                    title: 'إضافة عنوان جديد',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPlace(),
                          ));
                    }),
              ],
            )
          : const LoginButton(),
    );
  }
}
/**
 * 
 * 
 */



