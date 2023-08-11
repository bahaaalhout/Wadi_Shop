import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Widgets/profile_widgets/back_icon.dart';

import '../../Models/place.dart';

import '../../Provider/new_place_provider.dart';
import '../../constants.dart';
import 'location_input.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _keyState = GlobalKey<FormState>();
  String _enteredTitle = '';

  PlaceLocation? selectedLocation;

  void _addItem() async {
    if (_keyState.currentState!.validate()) {
      _keyState.currentState!.save();
      if (selectedLocation == null) {
        showCupertinoDialog(
          context: context,
          builder: ((ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Message'),
                content: const Text('Add The Location Please'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'),
                  ),
                ],
              )),
        );
      }
      if (selectedLocation == null) {
        return;
      }
      final user = FirebaseAuth.instance.currentUser;

      final addressRef = FirebaseFirestore.instance
          .collection('address')
          .doc(user!.uid)
          .collection('id');
      final snapshot = await addressRef.get();
      ref.read(userPlaceProvider.notifier).addItem(Place(
          title: _enteredTitle,
          location: selectedLocation!,
          id: snapshot.docs.length.toString()));
      const t = 'sss';
      Navigator.of(context).pop(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kprimaryColor,
        foregroundColor: Colors.white,
        title: const Text('إضافة عنوان جديد'),
        actions: const [BackIcon()],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: _keyState,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text(
                        'العنوان',
                        style: TextStyle(color: kprimaryColor),
                      ),
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 2) {
                        return 'Must be more than two character';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredTitle = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LocationInput(
                    onSelectLocation: (location) {
                      selectedLocation = location;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _addItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'اضافة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
