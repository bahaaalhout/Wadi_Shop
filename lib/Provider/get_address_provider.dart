import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/place.dart';
import '../Widgets/snakbar.dart';

final auth = FirebaseAuth.instance;
final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

class GetAddress extends StateNotifier<List<Place>> {
  GetAddress() : super([]);
  Future<List<Place>> getAddress(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    final addressRef = FirebaseFirestore.instance
        .collection('address')
        .doc(user!.uid)
        .collection('id');

    try {
      final snapshot = await addressRef.get();
      final state = snapshot.docs.map((doc) {
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
      return state;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());

      return [];
    }
  }

  Future<void> deleteAddress(String itemId, BuildContext context) async {
    final user = auth.currentUser;
    final favoriteRef = FirebaseFirestore.instance
        .collection('address')
        .doc(user!.uid)
        .collection('id');

    try {
      await favoriteRef.doc(itemId).delete().then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        return showSnackBar(context: context, content: 'تم الحذف');
      });
    } catch (e) {
      showSnackBar(
          content: 'Failed to remove item from favorites: $e',
          context: context);
    }
  }
}

final getAddressProvider =
    StateNotifierProvider<GetAddress, List<Place>>((ref) => GetAddress());

//--------------------------------------------------------------------------------------------------

