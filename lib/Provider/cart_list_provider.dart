import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final usernameProvider = StreamProvider.autoDispose<String>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    return userRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        // Assuming you have a field called 'username' in your user document
        return snapshot.get('username') ?? '';
      } else {
        return '';
      }
    });
  } else {
    return Stream.value('');
  }
});

//-------------------------------------------------------------------------------



