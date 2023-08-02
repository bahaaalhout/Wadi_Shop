import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadi_shop/Models/place.dart';
import 'package:wadi_shop/Widgets/login_button.dart';
import 'package:wadi_shop/Widgets/my_button.dart';
import 'package:wadi_shop/Widgets/profile_widgets/address_card.dart';

import 'package:wadi_shop/constants.dart';

import '../../Provider/myfavorite_provider.dart';
import '../../Widgets/profile_widgets/add_address.dart';
import '../../Widgets/profile_widgets/back_icon.dart';
import '../../Widgets/snakbar.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  Future<List<Place>> getAddress() async {
    final user = FirebaseAuth.instance.currentUser;

    final addressRef = FirebaseFirestore.instance
        .collection('address')
        .doc(user!.uid)
        .collection('id');

    try {
      final snapshot = await addressRef.get();
      final addressList = snapshot.docs.map((doc) {
        final data = doc.data();
        return Place(
          title: data['title'],
          location: PlaceLocation(
            latitude: data['lat'],
            longitude: data['lng'],
            address: data['address'],
          ),
        );
      }).toList();

      return addressList;
    } catch (e) {
      showSnackBar(
          content: 'Failed to retrieve favorites: $e', context: context);
      return [];
    }
  }

  Future<void> deleteAddress(String itemId) async {
    final user = auth.currentUser;
    final favoriteRef = FirebaseFirestore.instance
        .collection('address')
        .doc(user!.uid)
        .collection('id');

    try {
      await favoriteRef
          .doc(itemId)
          .delete()
          .then((value) => showSnackBar(context: context, content: 'تم الحذف'));
      setState(() {});
    } catch (e) {
      showSnackBar(
          content: 'Failed to remove item from favorites: $e',
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                FutureBuilder(
                  future: getAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data!.isEmpty) {
                      return const Expanded(
                        child: Center(child: Text('أضف عنوان جديد')),
                      );
                    } else {
                      final favoriteList = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: favoriteList!.length,
                          itemBuilder: (context, index) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: AddressCard(
                              address: favoriteList[index],
                              deleteItem: () {
                                deleteAddress('$index');
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
                    press: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPlace(),
                          ));
                    }),
              ],
            )
          : const LoginButton(),
    );
  }
}
